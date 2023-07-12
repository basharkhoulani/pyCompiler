#import compiler_register_allocator as compiler
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

class Compiler(compiler.Compiler):

    ###########################################################################
    # Shrink
    ###########################################################################

    def shrink_exp(self, e: expr) -> expr:
        match e:
            case BoolOp(And(), exp):
                return IfExp(exp[0], exp[1], Constant(False))
            case BoolOp(Or(), exp):
                return IfExp(exp[0], Constant(True), exp[1])
            case BinOp(left,op,right):
                return BinOp(self.shrink_exp(left),op,self.shrink_exp(right))
            case UnaryOp(op,stmt):
                return UnaryOp(op, self.shrink_exp(stmt))
            case IfExp(cons, then, els):
                return IfExp(self.shrink_exp(cons),self.shrink_exp(then), self.shrink_exp(els))
            case _:
                return e

    def shrink_stmt(self, s: stmt) -> stmt:
        match s:
            case Assign([Name(name)], expression):
                return Assign([Name(name)], self.shrink_exp(expression))
            
            case If(test, body, anso):
                body_out = []
                ans_out = []

                for ins in body:
                    body_out.append(self.shrink_stmt(ins))
                for ins in anso:
                    ans_out.append(self.shrink_stmt(ins))

                return If(self.shrink_exp(test), body_out, ans_out)

            case Expr(expression):
                return self.shrink_exp(expression)
            case _:
                raise Exception("WRONG DIKLARATION FROM IF CLASS")

    def shrink(self, p: Module) -> Module:
        result = []
        match p:
            case Module(body):
                for s in body:
                    result.append(self.shrink_stmt(s))
        return Module(result)

    ############################################################################
    # Remove Complex Operands
    ############################################################################

    def rco_exp(self, e: expr, need_atomic: bool) -> tuple[expr, compiler.Temporaries]:
        match e:
            case Expr(Call(func,[atm])):
                result = self.reco_call(func, atm)
            
            case Compare(left, [op], [right]):
                l = self.rco_exp(left, True)
                r = self.rco_exp(right, True)

                result = (Compare(l[0], [op], [r[0]]), l[1] + r[1])
            
            case UnaryOp(Not(), op):
                l = self.rco_exp(op, True)
                result = (UnaryOp(Not(), l[0]), l[1])
            
            case IfExp(con, thn, els):
                cons = []
                thns = []
                elses = []
                const = self.rco_exp(con, False)
                then = self.rco_exp(thn, False)
                elss = self.rco_exp(els,False)
                
                for x in const:
                    cons.append(Assign([x[0]], x[1]))
                
                for x in then:
                    thns.append(Assign([x[0]], x[1]))
                    
                for x in elss:
                    elses.append(Assign([x[0]], x[1]))
                
                result = (IfExp(Begin(const, cons[0]), Begin(then, thns[0]), Begin(elss, elses[0])), [])
                
            case _:
                return super().rco_exp(e, need_atomic)
            
        if need_atomic:
            tmp = get_fresh_tmp()
            result = result = (Name(tmp), result[1] + [(Name(tmp), result[0])])
        return result
                

    def rco_stmt(self, s: stmt) -> list[stmt]:
        match s:
            case If(con, thn, els):
                conExpr = self.rco_exp(con, False)
                thnout = []
                elsout = []

                for instr in thn:
                    thnout = thnout + self.rco_stmt(instr)
                for instr in els:
                    elsout = elsout + self.rco_stmt(instr)

                result: list[stmt] = []
                
                for temp in conExpr[1]:
                    result.append(Assign([temp[0]], temp[1]))
                    
                result.append(If(conExpr[0], thnout, elsout))
                
                return result
            
            case IfExp(test, body, elseBody):
                expr = self.rco_exp(IfExp(test, body, elseBody), False)

                result: list[stmt] = []
                for temp in expr[1]:
                    result.append(Assign([temp[0]], temp[1]))
                result.append(expr[0])
                return result
            case _:
                return super().rco_stmt(s)


    ############################################################################
    # Explicate Control
    ############################################################################

    def explicate_effect(self, e, cont, basic_blocks) -> list[stmt]:
        match e:
            case IfExp(test, body, orelse):
                # YOUR CODE HERE test
                pass
            case Call(func, args):
                # YOUR CODE HERE
                pass
            case Begin(body, result):
                # YOUR CODE HERE
                pass
            case _:
                # YOUR CODE HERE
                pass

    def explicate_assign(self, rhs, lhs, cont, basic_blocks) -> list[stmt]:
        match rhs:
            case IfExp(test, body, orelse):
                # YOUR CODE HERE
                pass
            case Begin(body, result):
                # YOUR CODE HERE
                pass
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
                # YOUR CODE HERE
                pass
            case IfExp(test, body, orelse):
                # YOUR CODE HERE
                pass
            case Begin(body, result):
                # YOUR CODE HERE
                pass
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
            case If(test, body, orelse):
                # YOUR CODE HERE
                pass

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
        # YOUR CODE HERE
            case _:
                return super().select_arg(e)

    def select_stmt(self, s: stmt) -> list[instr]:
        match s:
        # YOUR CODE HERE
            case _:
                return super().select_stmt(s)

    def select_instructions(self, p: Module) -> X86Program:
        # YOUR CODE HERE
        pass

    ###########################################################################
    # Patch Instructions
    ###########################################################################

    def patch_instr(self, i: instr) -> list[instr]:
        match i:
        # YOUR CODE HERE
            case _:
                return super().patch_instr(i)

    def patch_instructions(self, p: X86Program) -> X86Program:
        # YOUR CODE HERE
        pass

    ###########################################################################
    # Prelude & Conclusion
    ###########################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        # YOUR CODE HERE
        pass

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
