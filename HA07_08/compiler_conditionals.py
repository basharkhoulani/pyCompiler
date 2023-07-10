import compiler_register_allocator as compiler_register_allocator
from compiler_register_allocator import caller_saved_registers
from compiler import get_fresh_tmp
import compiler
from graph import UndirectedAdjList
from ast import *
from x86_ast import *
from utils import *

def create_block(stmts, basic_blocks):
    match stmts:
        case [Goto(l)]:
            return stmts
        case _:
            label = label_name(generate_name('block'))
            basic_blocks[label] = stmts
            return [Goto(label)]

class Compiler(compiler_register_allocator.Compiler):

    ###########################################################################
    # Shrink
    ###########################################################################

    def shrink_exp(self, e: expr) -> expr:
        match e:
            case Compare(left, [op], [right]):
                return Compare(self.shrink_exp(left), [op], [self.shrink_exp(right)])
            
            case BoolOp(And(), [a_expr, b_expr]):
                return IfExp(self.shrink_exp(a_expr), b_expr, Constant(False))
            case BoolOp(Or(), [a_expr, b_expr]):
                return IfExp(self.shrink_exp(a_expr), Constant(True), b_expr)

            case BinOp(left, op, right):
                return BinOp(self.shrink_exp(left), op, self.shrink_exp(right))
            case UnaryOp(op, right):
                return UnaryOp(op, self.shrink_exp(right))

            case IfExp(con, body, els):
                return IfExp(self.shrink_exp(con), self.shrink_exp(body), self.shrink_exp(els))

            case Call(Name(name), [expression]):
                return Call(Name(name), [self.shrink_exp(expression)])
            
            case _:
                return e

    def shrink_stmt(self, s: stmt) -> stmt:
        match s:
            case Assign([Name(name)], expression):
                return Assign([Name(name)], self.shrink_exp(expression))
            
            case If(test, body, anso):
                body_out = []
                ans_out = []

                for instr in body:
                    body_out.append(self.shrink_stmt(instr))
                for instr in anso:
                    ans_out.append(self.shrink_stmt(instr))

                return If(self.shrink_exp(test), body_out, ans_out)

            case Expr(expression):
                return Expr(self.shrink_exp(expression))
            
            case While(test, body, anso):
                body_out = []
                ans_out = []

                for instr in body:
                    body_out.append(self.shrink_stmt(instr))
                for instr in anso:
                    ans_out.append(self.shrink_stmt(instr))

                return While(self.shrink_exp(test), body_out, ans_out)

            case _: raise Exception("Unknown statement type: " + str(s))

    def shrink(self, p: Module) -> Module:
        o = []

        for instr in p.body:
            o.append(self.shrink_stmt(instr))

        return Module(o)

    ############################################################################
    # Remove Complex Operands
    ############################################################################

    def rco_exp(self, e: expr, need_atomic: bool) -> tuple[expr, compiler.Temporaries]:
        match e:
            case Compare(left, [op], [right]):
                nlhs = self.rco_exp(left, True)
                nrhs = self.rco_exp(right, True)

                result = (Compare(nlhs[0], [op], [nrhs[0]]), nlhs[1] + nrhs[1])
            case UnaryOp(Not(), operand):
                nlhs = self.rco_exp(operand, True)
                result = (UnaryOp(Not(), nlhs[0]), nlhs[1])
            case IfExp(cond, body, anso):
                con = []
                cons = self.rco_exp(cond, False)
                for x in cons[1]:
                    con.append(Assign([x[0]], x[1]))

                lhs = []
                nlhs = self.rco_exp(body, False)
                for x in nlhs[1]:
                    lhs.append(Assign([x[0]], x[1]))

                rhs = []
                nrhs = self.rco_exp(anso, False)
                for x in nrhs[1]:
                    rhs.append(Assign([x[0]], x[1]))

                result = (IfExp(Begin(con, cons[0]), Begin(lhs, nlhs[0]), Begin(rhs, nrhs[0])), [])

            case Call(Name(func), [v]):
                o = self.rco_exp(v, True)
                result = (Call(Name(func), [o[0]]), o[1])
            case _:
                return super().rco_exp(e, need_atomic)
            
            
        if need_atomic:
            tmp = get_fresh_tmp()
            result = (Name(tmp), result[1] + [(Name(tmp), result[0])])
        
        return result

    def rco_stmt(self, s: stmt) -> list[stmt]:
        match s:
            case If(test, body, anso):
                testExpr = self.rco_exp(test, False)

                body_out = []
                ans_out = []

                for instr in body:
                    body_out = body_out + self.rco_stmt(instr)
                for instr in anso:
                    ans_out = ans_out + self.rco_stmt(instr)

                result: list[stmt] = []
                for temp in testExpr[1]:
                    result.append(Assign([temp[0]], temp[1]))
                result.append(If(testExpr[0], body_out, ans_out))
                return result
            case While(test, body, anso):
                testExpr = self.rco_exp(test, False)

                body_out = []
                ans_out = []

                for instr in body:
                    body_out = body_out + self.rco_stmt(instr)
                for instr in anso:
                    ans_out = ans_out + self.rco_stmt(instr)

                result: list[stmt] = []
                for temp in testExpr[1]:
                    result.append(Assign([temp[0]], temp[1]))
                result.append(While(testExpr[0], body_out, ans_out))
                return result
            case IfExp(test, body, elseBody):
                expr = self.rco_exp(IfExp(test, body, elseBody), False)

                result: list[stmt] = []
                for temp in expr[1]:
                    result.append(Assign([temp[0]], temp[1]))
                result.append(Expr(expr[0]))
                return result
            case _:
                return super().rco_stmt(s)

    ############################################################################
    # Explicate Control
    ############################################################################

    def explicate_effect(self, e, cont, basic_blocks) -> list[stmt]:
        match e:
            case IfExp(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)
                return self.explicate_pred(test, 
                                           [self.explicate_effect(body, goto_cont, basic_blocks)], 
                                           [self.explicate_effect(orelse, goto_cont, basic_blocks)])
            case Call(func, args):
                return [Expr(Call(func, args))] + cont
            case Begin(body, result):
                return self.explicate_stmt_list(body, self.explicate_effect(result, cont, basic_blocks), basic_blocks)
            case _:
                return [Expr(e)] + cont

    def explicate_assign(self, rhs, lhs, cont, basic_blocks) -> list[stmt]:
        match rhs:
            case IfExp(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)
                return self.explicate_pred(test, 
                                           self.explicate_assign(body, lhs, [], basic_blocks) + goto_cont
                                           ,self.explicate_assign(orelse, lhs, [], basic_blocks) + goto_cont,
                                             basic_blocks)
            case Begin(body, result):
                return self.explicate_stmt_list(body, self.explicate_assign(result, lhs, cont, basic_blocks), basic_blocks)
            case _:
                return [Assign([lhs], rhs)] + cont

    def explicate_pred(self, cnd, thn, els, basic_blocks) -> list[stmt]:
        match cnd:
            case Compare(left, [op], [right]):
                goto_thn = create_block(thn, basic_blocks)
                goto_els = create_block(els, basic_blocks)
                return [If(cnd, goto_thn, goto_els)]
            case Constant(True):
                return thn
            case Constant(False):
                return els
            case UnaryOp(Not(), operand):
                return self.explicate_pred(operand, els, thn, basic_blocks)
            case IfExp(test, body, orelse):
                goto_thn = create_block(thn, basic_blocks)
                goto_els = create_block(els, basic_blocks)

                bodyTrans = self.explicate_pred(body, goto_thn, goto_els, basic_blocks)
                orelseTrans = self.explicate_pred(orelse, goto_thn, goto_els, basic_blocks)

                return self.explicate_pred(test, bodyTrans, orelseTrans, basic_blocks)
            case Begin(body, result):
                out = self.explicate_stmt_list(body, [], basic_blocks)
                return out + self.explicate_pred(result, thn, els, basic_blocks)
            case _:
                return [If(Compare(cnd, [Eq()], [Constant(False)]),
                        create_block(els, basic_blocks),
                        create_block(thn, basic_blocks))]

    def explicate_stmt(self, s: stmt, cont, basic_blocks) -> list[stmt]:
        match s:
            case Assign([lhs], rhs):
                return self.explicate_assign(rhs, lhs, cont, basic_blocks)
            case Expr(value):
                return self.explicate_effect(value, cont, basic_blocks)
            case IfExp(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)
                return self.explicate_pred(test, self.explicate_effect(body, goto_cont, basic_blocks), self.explicate_effect(orelse, goto_cont, basic_blocks), basic_blocks)
            case If(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)

                return self.explicate_pred(test, self.explicate_stmt_list(body, goto_cont, basic_blocks), self.explicate_stmt_list(orelse, goto_cont, basic_blocks), basic_blocks)
            
            case While(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)
            
                #create start block
                label = label_name(generate_name('block'))
                basic_blocks[label] = []
                goto_loop_start = [Goto(label)]

                #progress else blocks
                goto_loop_body = create_block(self.explicate_stmt_list(body, goto_loop_start, basic_blocks), basic_blocks)
                goto_loop_else = create_block(self.explicate_stmt_list(orelse, goto_cont, basic_blocks), basic_blocks)

                basic_blocks[label] = self.explicate_pred(test, goto_loop_body, goto_loop_else, basic_blocks)
                return goto_loop_start
            case _:
                raise Exception("unkown statement")
            
    def explicate_stmt_list(self, s, cont, basic_blocks) -> list[stmt]:
        out = cont
        for x in reversed(s):
            out = self.explicate_stmt(x, out, basic_blocks)

        return out


    def explicate_control(self, p: Module):
        match p:
            case Module(body):
                new_body = [Return(Constant(0))]
                basic_blocks = {}
                for s in reversed(body):
                    new_body = self.explicate_stmt(s, new_body, basic_blocks)
                basic_blocks[label_name('start')] = new_body
                return CProgram(basic_blocks)

    ############################################################################
    # Select Instructions
    ############################################################################

    def select_arg(self, e: expr) -> arg:
        match e:
            case Constant(False):
                return Immediate(0)
            case Constant(True):
                return Immediate(1)
            case False:
                return Immediate(0)
            case True:
                return Immediate(1)
            case _:
                return super().select_arg(e)

    def select_compareType(self, op) -> str:
        match op:
            case Eq():
                return "e"
            case NotEq():
                return "ne"
            case Lt():
                return "l"
            case LtE():
                return "le"
            case Gt():
                return "g"
            case GtE():
                return "ge"
            case _:
                raise Exception("unkown operator")

    def select_assign(self, name: str, exp: expr) -> list[instr]:
        match exp:
            case Compare(a, [op], [b]):
                return [
                    Instr("cmpq", [self.select_arg(b), self.select_arg(a)]),
                    Instr("set" + self.select_compareType(op), [Variable(name)])
                ]
            case Not(arg):
                return [
                    Instr("movq", [self.select_arg(arg), Variable(name)]),
                    Instr("xorq", [Immediate(1), Variable(name)])
                ]
        return super().select_assign(name, exp)

    def select_stmt(self, s: stmt) -> list[instr]:
        match s:
            case If(Compare(a, [op], [b]), [Goto(destThn)], [Goto(destOrEls)]):
                #make compare
                out = []
                out.append(Instr("cmpq", [self.select_arg(b), self.select_arg(a)]))
                out.append(JumpIf(self.select_compareType(op), destThn))
                out.append(Jump(destOrEls))
                return out
            case Return(val):
                return [
                    Instr("movq", [self.select_arg(val), Reg("rax")]),
                    Jump("conclusion")
                ]
            case Goto(target):
                return [Jump(target)]
            case _:
                return super().select_stmt(s)

    def select_instructions(self, p: Module) -> X86Program:
        out = {}

        for blockID, instrs in p.body.items():
            out_instr = []

            for i in instrs:
                out_instr = out_instr + self.select_stmt(i)

            out[blockID] = out_instr

        return X86Program(out)

    ###########################################################################
    # Patch Instructions
    ###########################################################################

    def patch_instr(self, i: instr) -> list[instr]:
        match i:
            case Jump(label):
                return [Jump(label)]
            case JumpIf(cc, label):
                return [JumpIf(cc, label)]
            case Callq(label, args):
                return [
                    Callq("saveRegs", 0),
                    i,
                    Callq("restoreRegs", 0)
                ]
            case _:
                return super().patch_instr(i)

    def patch_instructions(self, p: X86Program) -> X86Program:
        blocks = {}
        self.stack_before = self.stack_size

        for label, instrs in p.body.items():
            blocks[label] = self.patch_instrs(instrs)

        #add save/load reg functions
        saveRegs = self.save(caller_saved_registers)
        saveRegs.append(Instr('retq', []))
        restoreRegs = self.restore(caller_saved_registers)
        restoreRegs.append(Instr('retq', []))

        blocks["saveRegs"] = saveRegs
        blocks["restoreRegs"] = restoreRegs

        return X86Program(blocks)

    ###########################################################################
    # Prelude & Conclusion
    ###########################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        adjust_stack_size = self.stack_size if self.stack_size % 16 == 0 else self.stack_size + 8

        prelude = [
            Instr("pushq", [Reg("rbp")]), 
            Instr("movq", [Reg("rsp"), Reg("rbp")]),
            Instr('subq', [Immediate(adjust_stack_size), Reg('rsp')]),
            Jump("start")
        ]
        postlude = [
            Instr('addq', [Immediate(adjust_stack_size), Reg('rsp')]),
            Instr('popq', [Reg('rbp')]), 
            Instr('retq', [])
        ]

        blocks = p.body
        blocks["main"] = prelude
        blocks["conclusion"] = postlude
        return X86Program(blocks)

    ##################################################
    # Compiler
    ##################################################

    def compile(self, s: str, logging=False) -> X86Program:
        compiler_passes = {
            'shrink': self.shrink,
            'remove complex operands': self.remove_complex_operands,
            'explicate control': self.explicate_control,
            'select instructions': self.select_instructions,
            'assign homes': self.assign_homes,
            'patch instructions': self.patch_instructions,
            'prelude & conclusion': self.prelude_and_conclusion,
        }

        current_program = parse(s)

        if logging == True:
            print()
            print('==================================================')
            print(' Input program')
            print('==================================================')
            print()
            print(s)

        for pass_name, pass_fn in compiler_passes.items():
            current_program = pass_fn(current_program)

            if logging == True:
                print()
                print('==================================================')
                print(f' Output of pass: {pass_name}')
                print('==================================================')
                print()
                print(current_program)

        return current_program


##################################################
# Execute
##################################################

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: python compiler.py <source filename>')
    else:
        file_name = sys.argv[1]
        with open(file_name) as f:
            print(f'Compiling program {file_name}...')

            try:
                program = f.read()
                compiler = Compiler()
                x86_program = compiler.compile(program, logging=True)

                with open(file_name + '.s', 'w') as output_file:
                    output_file.write(str(x86_program))

            except:
                print(
                    'Error during compilation! **************************************************'
                )
                import traceback

                traceback.print_exception(*sys.exc_info())
