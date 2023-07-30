from ast import *
from x86_ast import *
import x86_ast
from graph import *
from utils import *
from dataflow_analysis import analyze_dataflow
import copy
from type_check_Ltup import TypeCheckLtup
import type_check_Ctup

Binding = tuple[Name, expr]
Temporaries = list[Binding]
get_fresh_tmp = lambda: generate_name('tmp')

registers_for_coloring = [
    Reg('rcx'),
    Reg('rdx'),
    Reg('rsi'),
    Reg('r8'),
    Reg('r9'),
    Reg('r10'),
    Reg('r11'),
    Reg('r15'),
]


def create_block(stmts, basic_blocks):
    match stmts:
        case [Goto(l)]:
            return stmts
        case _:
            label = label_name(generate_name('block'))
            basic_blocks[label] = stmts
            return [Goto(label)]


def cc(op):
    match op:
        case Eq():
            return 'e'
        case NotEq():
            return 'ne'
        case Lt():
            return 'l'
        case LtE():
            return 'le'
        case Gt():
            return 'g'
        case GtE():
            return 'ge'

class Compiler:

    def tmps_to_stmts(self, tmps: Temporaries) -> list[stmt]:
        result = []
        for tmp in tmps:
            lhs, rhs = tmp
            result.append(Assign([lhs], rhs))
        return result

    ###########################################################################
    # Shrink
    ###########################################################################

    def shrink_exp(self, e: expr) -> expr:
        match e:
            case Constant(_) | Name(_):
                return e
            case BoolOp(And(), [e1, e2]):
                return IfExp(self.shrink_exp(e1), self.shrink_exp(e2), Constant(False))
            case BoolOp(Or(), [e1, e2]):
                return IfExp(self.shrink_exp(e1), Constant(True), self.shrink_exp(e2))
            case IfExp(e1, e2, e3):
                return IfExp(
                    self.shrink_exp(e1), self.shrink_exp(e2), self.shrink_exp(e3)
                )
            case Compare(left, [op], [right]):
                return Compare(self.shrink_exp(left), [op], [self.shrink_exp(right)])
            case BinOp(e1, op, e2):
                return BinOp(self.shrink_exp(e1), op, self.shrink_exp(e2))
            case UnaryOp(op, operand):
                return UnaryOp(op, self.shrink_exp(operand))
            case Call(Name('input_int'), []):
                return e
            case Call(Name('len'), [expr]):
                return Call(Name('len'), [self.shrink_exp(expr)])
            case Subscript(expr, Constant(index), Load()):
                return Subscript(self.shrink_exp(expr), Constant(index), Load())
            case Tuple(exprs, Load()):
                return Tuple([self.shrink_exp(expr) for expr in exprs], Load())
            case Expr(expr):
                return Expr(self.shrink_exp(expr))
            case GlobalValue(_):
                return e
            case _:
                raise Exception('unhandled case in shrink_exp:' + repr(e))

    def shrink_stmt(self, s: stmt) -> stmt:
        match s:
            case If(test, thn, els):
                test_shrink = self.shrink_exp(test)
                thn_shrink = []
                for s in thn:
                    thn_shrink.append(self.shrink_stmt(s))
                els_shrink = []
                for s in els:
                    els_shrink.append(self.shrink_stmt(s))
                return If(test_shrink, thn_shrink, els_shrink)
            case While(test, body, []):
                body_shrink = []
                for s in body:
                    body_shrink.append(self.shrink_stmt(s))
                return While(self.shrink_exp(test), body_shrink, [])
            case Expr(Call(Name('print'), [arg])):
                return Expr(Call(Name('print'), [self.shrink_exp(arg)]))
            case Expr(e):
                return Expr(self.shrink_exp(e))
            case Assign(lhs, rhs):
                return Assign(lhs, self.shrink_exp(rhs))
            case Collect(_):
                return s
            case _:
                raise Exception('unhandled case in shrink_stmt:' + repr(s))

    def shrink(self, p: Module) -> Module:
        new_body = []
        for stm in p.body:
            new_body.append(self.shrink_stmt(stm))
        return Module(new_body)

    ###########################################################################
    # Expose Allocation
    ###########################################################################
    
    def expose_allocation_expr(self, e: expr) -> expr:
        match e:
            case UnaryOp(op, expr):
                return UnaryOp(op, self.expose_allocation_expr(expr))
            case BinOp(e1, op, e2):
                return BinOp(self.expose_allocation_expr(e1), op, self.expose_allocation_expr(e2))
            case BoolOp(op, [e1, e2]):
                return BoolOp(op, [self.expose_allocation_expr(e1), self.expose_allocation_expr(e2)])
            case Compare(e1, [cmp], [e2]):
                return Compare(self.expose_allocation_expr(e1), [cmp], [self.expose_allocation_expr(e2)])
            case IfExp(e1, e2, e3):
                return IfExp(self.expose_allocation_expr(e1), self.expose_allocation_expr(e2), self.expose_allocation_expr(e3))
            case Tuple(exprs, Load()):
                nexprs = [self.expose_allocation_expr(expr) for expr in exprs]
                
                # 1: Assign expresssions to variables for tuple
                assignments: list[stmt] = []
                for nexpr in nexprs:
                    assignments.append(Assign([Name(generate_name('init'))], nexpr))
                    
                # 2: Check for space
                test = Expr(Compare(BinOp(GlobalValue('free_ptr'), Add(), Constant(len(nexprs) * 8 + 8)), [Lt()], [GlobalValue('fromspace_end')]))
                thn = []
                els = [Collect(len(nexprs) * 8 + 8)]
                allocate = self.shrink_stmt(If(test, thn, els))
                
                # 3: Allocate
                tup_name = Name(generate_name('tup'))
                tup = Assign([tup_name], Allocate(Constant(len(nexprs)), e.has_type))
                
                # 4: Assign tuple to pointer
                tup_assigns: list[stmt] = []
                index = 0
                for assignment in assignments:
                    tup_assigns.append(Assign([Subscript(tup_name, Constant(index), Load())], assignment.targets[0]))
                    index += 1
                    
                result = Begin(assignments + [allocate, tup] + tup_assigns, tup_name)
                return result
                
            case _:
                return e
            
    def expose_allocation_stmts(self, stmts: list[stmt]) -> list[stmt]:
        return [self.expose_allocation_stmt(s) for s in stmts]

    def expose_allocation_stmt(self, s: stmt) -> stmt:
        match s:
            case Expr(Callq(Name('print'), [expr])):
                return Expr(Callq(Name('print'), [self.expose_allocation_expr(expr)]))
            case Expr(expr):
                return Expr(self.expose_allocation_expr(expr))
            case Assign([Name(var)], expr):
                return Assign([Name(var)], self.expose_allocation_expr(expr))
            case If(test, thn, els):
                return If(
                    self.expose_allocation_expr(test),
                    self.expose_allocation_stmts(thn),
                    self.expose_allocation_stmts(els))
            case While(test, stmts, []):
                nstmts = [self.expose_allocation_stmt(s) for s in stmts]
                return While(self.expose_allocation_expr(test), nstmts, [])
            

    def expose_allocation(self, p: Module) -> Module:
        TypeCheckLtup().type_check(p)
        new_body = []
        for stm in p.body:
            new_body.append(self.expose_allocation_stmt(stm))
        return Module(new_body)

    ############################################################################
    # Remove Complex Operands
    ############################################################################

    def rco_exp(self, e: expr, need_atomic: bool) -> tuple[expr, Temporaries]:
        match e:
            case Name(_) | Constant(_):
                return (e, [])
            case Call(Name('input_int'), []):
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (Name(fresh_tmp), [(Name(fresh_tmp), e)])
                return (e, [])
            case UnaryOp(USub(), e1):
                atm, tmps = self.rco_exp(e1, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmps + [(Name(fresh_tmp), UnaryOp(USub(), atm))],
                    )
                return (UnaryOp(USub(), atm), tmps)
            case BinOp(e1, op, e2):
                atm1, tmps1 = self.rco_exp(e1, True)
                atm2, tmps2 = self.rco_exp(e2, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmps1 + tmps2 + [(Name(fresh_tmp), BinOp(atm1, op, atm2))],
                    )
                return (BinOp(atm1, op, atm2), tmps1 + tmps2)
            case BoolOp(op, [e1, e2]):
                atm1, tmps1 = self.rco_exp(e1, True)
                atm2, tmps2 = self.rco_exp(e2, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmps1 + tmps2 + [(Name(fresh_tmp), BoolOp(op, [atm1, atm2]))],
                    )
                return (BoolOp(op, [atm1, atm2]), tmps1 + tmps2)

            case Compare(left, [op], [right]):
                atml, tmpsl = self.rco_exp(left, True)
                atmr, tmpsr = self.rco_exp(right, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmpsl
                        + tmpsr
                        + [(Name(fresh_tmp), Compare(atml, [op], [atmr]))],
                    )
                return (Compare(atml, [op], [atmr]), tmpsl + tmpsr)
            case IfExp(e1, e2, e3):
                atm1, tmps1 = self.rco_exp(e1, False)
                atm2, tmps2 = self.rco_exp(e2, False)
                atm3, tmps3 = self.rco_exp(e3, False)

                begin1 = self.tmps_to_stmts(tmps1)
                begin2 = self.tmps_to_stmts(tmps2)
                begin3 = self.tmps_to_stmts(tmps3)

                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        [
                            (
                                Name(fresh_tmp),
                                IfExp(
                                    Begin(begin1, atm1),
                                    Begin(begin2, atm2),
                                    Begin(begin3, atm3),
                                ),
                            )
                        ],
                    )

                return (
                    IfExp(
                        Begin(begin1, atm1), Begin(begin2, atm2), Begin(begin3, atm3)
                    ),
                    [],
                )
            case Begin(stmts, ex):
                nstmts = []
                for stmt in stmts:
                    for nstmt in self.rco_stmt(stmt):
                        nstmts.append(nstmt)
                return (Begin(nstmts, ex), [])
            case Subscript(e1, e2, Load()):
                atm1, tmp1 = self.rco_exp(e1, True)
                atm2, tmp2 = self.rco_exp(e2, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmp1 + tmp2 + [(Name(fresh_tmp), Subscript(atm1, atm2, Load()))],
                    )
                return (Subscript(atm1, atm2, Load()), tmp1 + tmp2)
            case Call(Name('len'), [e]):
                atm1, tmp1 = self.rco_exp(e, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmp1 + [(Name(fresh_tmp), Call(Name('len'), [atm1]))],
                    )
                return (Call(Name('len'), [atm1]), tmp1)
            case Allocate(n, t):
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        [(Name(fresh_tmp), Allocate(n, t))],
                    )
                return (e, [])
            case GlobalValue(v):
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        [(Name(fresh_tmp), GlobalValue(v))],
                    )
                return (e, [])
            case Expr(expr):
                return self.rco_exp(expr, need_atomic)
            case _:
                raise Exception('unhandled case in rco_exp ' + repr(e))

    def rco_stmt(self, s: stmt) -> list[stmt]:
        match s:
            case Expr(Call(Name('print'), [e])):
                atm, tmps = self.rco_exp(e, True)
                return self.tmps_to_stmts(tmps) + [Expr(Call(Name('print'), [atm]))]
            case Expr(e):
                atm, tmps = self.rco_exp(e, False)
                return self.tmps_to_stmts(tmps) + [Expr(atm)]
            case Assign([Name(var)], e):
                atm, tmps = self.rco_exp(e, False)
                return self.tmps_to_stmts(tmps) + [Assign([Name(var)], atm)]
            case If(test, thn, els):
                atm, tmps = self.rco_exp(test, False)

                rco_thn = []
                for s in thn:
                    rco_thn += self.rco_stmt(s)

                rco_els = []
                for s in els:
                    rco_els += self.rco_stmt(s)

                return self.tmps_to_stmts(tmps) + [If(atm, rco_thn, rco_els)]
            case While(test, body, []):
                atm, tmps = self.rco_exp(test, False)

                rco_body = []
                for s in body:
                    rco_body += self.rco_stmt(s)

                return self.tmps_to_stmts(tmps) + [While(atm, rco_body, [])]
            case Collect(n):
                return [s]
            case Assign([Subscript(e1, e2, Load())], e3):
                atm1, tmps1 = self.rco_exp(e1, True)
                atm2, tmps2 = self.rco_exp(e2, True)
                atm3, tmps3 = self.rco_exp(e3, True)
                
                result = self.tmps_to_stmts(tmps1 + tmps2 + tmps3)
                return result + [Assign([Subscript(atm1, atm2, Load())], atm3)]
            case _:
                raise Exception('unhandled case in rco_stmt ' + repr(s))

    def remove_complex_operands(self, p: Module) -> Module:
        match p:
            case Module(body):
                new_body = []
                for stm in body:
                    new_body += self.rco_stmt(stm)
                return Module(new_body)

    ############################################################################
    # Explicate Control
    ############################################################################

    def explicate_effect(self, e, cont, basic_blocks) -> list[stmt]:
        match e:
            case IfExp(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)
                body_instr = self.explicate_effect(body, goto_cont, basic_blocks)
                orelse_instr = self.explicate_effect(orelse, goto_cont, basic_blocks)

                return self.explicate_pred(test, body_instr, orelse_instr, basic_blocks)
            case Call(func, args):
                return [Expr(e)] + cont
            case Begin(body, result):
                new_body = self.epxlicate_effect(result, cont, basic_blocks) + [cont]
                for s in reversed(body):
                    new_body = self.epxlicate_stmt(s, new_body, basic_blocks)
                return new_body
            case _:
                return cont

    def explicate_assign(self, rhs, lhs, cont, basic_blocks) -> list[stmt]:
        match rhs:
            case IfExp(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)

                body_instr = self.explicate_assign(body, lhs, goto_cont, basic_blocks)
                orelse_instr = self.explicate_assign(
                    orelse, lhs, goto_cont, basic_blocks
                )

                return self.explicate_pred(test, body_instr, orelse_instr, basic_blocks)
            case Begin(body, result):
                new_body = self.explicate_assign(result, lhs, cont, basic_blocks)
                for s in reversed(body):
                    new_body = self.explicate_stmt(s, new_body, basic_blocks)
                return new_body
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

                new_body_if_cond = self.explicate_pred(
                    body, goto_thn, goto_els, basic_blocks
                )

                new_orelse_if_cond = self.explicate_pred(
                    orelse, goto_thn, goto_els, basic_blocks
                )

                return self.explicate_pred(
                    test, new_body_if_cond, new_orelse_if_cond, basic_blocks
                )
            case Begin(body, result):
                new_body = self.explicate_pred(result, thn, els, basic_blocks)
                for s in reversed(body):
                    new_body = self.explicate_stmt(s, new_body, basic_blocks)

                return new_body
            case _:
                return [
                    If(
                        Compare(cnd, [Eq()], [Constant(False)]),
                        create_block(els, basic_blocks),
                        create_block(thn, basic_blocks),
                    )
                ]

    def explicate_stmt(self, s: stmt, cont, basic_blocks) -> list[stmt]:
        match s:
            case Assign([lhs], rhs):
                return self.explicate_assign(rhs, lhs, cont, basic_blocks)
            case Expr(value):
                return self.explicate_effect(value, cont, basic_blocks)
            case If(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)

                explicate_body = []
                explicate_body += goto_cont
                for s in reversed(body):
                    explicate_body = self.explicate_stmt(
                        s, explicate_body, basic_blocks
                    )

                explicate_orelse = []
                explicate_orelse += goto_cont
                for s in reversed(orelse):
                    explicate_orelse = self.explicate_stmt(
                        s, explicate_orelse, basic_blocks
                    )

                return self.explicate_pred(
                    test, explicate_body, explicate_orelse, basic_blocks
                )
            case While(test, body, []):
                goto_cont = create_block(cont, basic_blocks)

                label = label_name(generate_name('loop'))
                goto_loop = [Goto(label)]

                explicate_body = goto_loop
                for s in reversed(body):
                    explicate_body = self.explicate_stmt(
                        s, explicate_body, basic_blocks
                    )

                basic_blocks[label] = self.explicate_pred(
                    test, explicate_body, goto_cont, basic_blocks
                )

                return goto_loop
            case Collect(n):
                return [Collect(n)] + cont
            case _:
                raise Exception('unhandled case in explicate_stmt: ' + repr(s))

    def explicate_control(self, p: Module) -> CProgram:
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


    ###########################################################################
    # Uncover Live
    ###########################################################################


    ############################################################################
    # Build Interference
    ############################################################################


    ############################################################################
    # Allocate Registers
    ############################################################################

  
    ############################################################################
    # Assign Homes
    ############################################################################


    ###########################################################################
    # Patch Instructions
    ###########################################################################


    ###########################################################################
    # Prelude & Conclusion
    ###########################################################################


    ##################################################
    # Compiler
    ##################################################

    def compile(self, s: str, logging=False) -> X86Program:
        compiler_passes = {
            'shrink': self.shrink,
            'expose allocation': self.expose_allocation,
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
