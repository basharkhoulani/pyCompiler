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
    Reg('r15')
]

def create_block(stmts: list[stmt], basic_blocks) -> list[stmt]:
    match stmts:
        case [Goto(label)]:
            return stmts
        case _:
            label = label_name(generate_name('block'))
            basic_blocks[label] = stmts
            return [Goto(label)]

def cc(op: cmpop) -> str:
    match op:
        case Eq() | Is():
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
        case _:
            raise Exception('unhandled case in cc:' + repr(op))

class Compiler:

    def tmps_to_stmts(self, tmps: Temporaries) -> list[stmt]:
        result = []
        for tmp in tmps:
            result.append(Assign(tmp[0], tmp[1]))
        return result

    ###########################################################################
    # Shrink
    ###########################################################################

    def shrink_exp(self, e: expr) -> expr:
        match e:
            case Constant(_) | Name(_) | GlobalValue(_) | Call(Name('input_int'), []):
                return e
            case BoolOp(And(), [e1, e2]):
                return IfExp(self.shrink_exp(e1), self.shrink_exp(e2), Constant(False))
            case BoolOp(Or(), [e1, e2]):
                return IfExp(self.shrink_exp(e1), Constant(True), self.shrink_exp(e2))
            case IfExp(test, thn, els):
                return IfExp(self.shrink_exp(test), self.shrink_exp(thn), self.shrink_exp(els))
            case Compare(e1, [cmp], [e2]):
                return Compare(self.shrink_exp(e1), [cmp], [self.shrink_exp(e2)])
            case BinOp(e1, op, e2):
                return BinOp(self.shrink_exp(e1), op, self.shrink_exp(e2))
            case UnaryOp(op, e):
                return UnaryOp(op, self.shrink_exp(e))
            case Call(Name('len'), [e]):
                return Call(Name('len'), [self.shrink_exp(e)])
            case Subscript(exp, Constant(index), Load()):
                return Subscript(self.shrink_exp(exp), Constant(index), Load())
            case Tuple(elts, Load()):
                return Tuple([self.shrink_exp(e) for e in elts], Load())
            case Expr(exp):
                return Expr(self.shrink_exp(exp))
            case _:
                raise Exception('unhandled case in shrink_exp:' + repr(e))

    def shrink_stmt(self, stm: stmt) -> stmt:
        match stm:
            case If(test, thn, els):
                test_shrink = self.shrink_exp(test)
                thn_shrink = [self.shrink_stmt(s) for s in thn]
                els_shrink = [self.shrink_stmt(s) for s in els]
                return If(test_shrink, thn_shrink, els_shrink)
            case While(test, body, []):
                test_shrink = self.shrink_exp(test)
                body_shrink = [self.shrink_stmt(s) for s in body]
                return While(test_shrink, body_shrink, [])
            case Expr(Call(Name('print'), [e])):
                return Expr(Call(Name('print'), [self.shrink_exp(e)]))
            case Expr(e):
                return Expr(self.shrink_exp(e))
            case Assign(lhs, rhs):
                return Assign(lhs, self.shrink_exp(rhs))
            case Collect(_):
                return stm
            case _:
                raise Exception('unhandled case in shrink_stmt:' + repr(stm))


    def shrink(self, p: Module) -> Module:
        new_body = []
        for stm in p.body:
            new_body.append(self.shrink_stmt(stm))
        return Module(new_body)

    ###########################################################################
    # Expose Allocation
    ###########################################################################

    def expose_allocation_exp(self, e: expr) -> expr:
        match e:
            case UnaryOp(op, exp):
                return UnaryOp(op, self.expose_allocation_exp(exp))
            case BinOp(e1, op, e2):
                return BinOp(self.expose_allocation_exp(e1), op, self.expose_allocation_exp(e2))
            case BoolOp(op, [e1, e2]):
                return BoolOp(op, [self.expose_allocation_exp(e1), self.expose_allocation_exp(e2)])
            case Compare(e1, [cmp], [e2]):
                return Compare(self.expose_allocation_exp(e1), [cmp], [self.expose_allocation_exp(e2)])
            case IfExp(test, thn, els):
                return IfExp(self.expose_allocation_exp(test), self.expose_allocation_exp(thn), self.expose_allocation_exp(els))
            case Tuple(elts, Load()):
                exprs = [self.expose_allocation_exp(e) for e in elts]

                assignments: list[stmt] = []
                for exp in exprs:
                    tmp = Name(generate_name('init'))
                    assignments.append(Assign([tmp], exp))

                left_side_check = BinOp(GlobalValue('free_ptr'), Add(), Constant(len(exprs) * 8 + 8))
                right_side_check = GlobalValue('fromspace_end')
                check = Expr(Compare(left_side_check, [Lt()], [right_side_check]))
                thn = []
                els = [Collect(len(exprs) * 8 + 8)]
                allocate = self.shrink_stmt(If(check, thn, els))

                tuple_name = Name(generate_name('tup'))
                tup = Assign([tuple_name], Allocate(len(exprs), e.has_type))

                tup_assigns: list[stmt] = []
                index = 0
                for assign in assignments:
                    tup_assigns.append(Assign([Subscript(tuple_name, Constant(index), Load())], assign.targets[0]))
                    index += 1
                result = Begin(assignments + [allocate, tup] + tup_assigns, tuple_name)
                return result
    def expose_allocation_stmt(self, stm: stmt) -> stmt:
        match stm:
            case Expr(Call(Name('print'), [e])):
                return Expr(Call(Name('print'), [self.expose_allocation_exp(e)]))
            case Expr(e):
                return Expr(self.expose_allocation_exp(e))
            case Assign(lhs, rhs):
                return Assign(lhs, self.expose_allocation_exp(rhs))
            case If(test, thn, els):
                return If(self.expose_allocation_exp(test),
                          [self.expose_allocation_stmt(s) for s in thn],
                          [self.expose_allocation_stmt(s) for s in els]
                )
            case While(test, body, []):
                return While(self.expose_allocation_exp(test),
                                [self.expose_allocation_stmt(s) for s in body],
                                []
                )

    def expose_allocation(self, p: Module) -> Module:
        TypeCheckLtup().type_check(p)
        new_body = []
        for stm in p.body:
            new_body.append(self.expose_allocation_stmt(stm))
        return Module(new_body)

    ############################################################################
    # Remove Complex Operands
    ############################################################################


    ############################################################################
    # Explicate Control
    ############################################################################


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
