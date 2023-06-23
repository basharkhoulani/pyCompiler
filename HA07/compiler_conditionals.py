#import compiler_register_allocator as compiler
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
            case _:
                return e

    def shrink_stmt(self, s: stmt) -> stmt:
        match s:
            case If(test, body, orelse):
                exp = self.shrink_exp(test)
                body = [self.shrink_stmt(s) for s in body]
                orelse = [self.shrink_stmt(s) for s in orelse]
                return If(exp, body, orelse)
            case Assign([lhs], rhs):
                return Assign([lhs], self.shrink_exp(rhs))
            case Expr(Call(Name('print'), [arg])):
                return Expr(Call(Name('print'), [self.shrink_exp(arg)]))
            case Expr(value):
                return Expr(self.shrink_exp(value))
            case _:
                raise Exception(f'Unexpected statement: {s}')

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
            case IfExp(test, body, orelse):
                test_exp, test_temps = self.rco_exp(test, False)
                body_exp, body_temps = self.rco_exp(body, False)
                orelse_exp, orelse_temps = self.rco_exp(orelse, False)

                begin_body = Begin([Assign([name], exp) for name, exp in body_temps], body_exp)
                begin_orelse = Begin([Assign([name], exp) for name, exp in orelse_temps], orelse_exp)
                end = IfExp(test_exp, begin_body, begin_orelse)
                if need_atomic:
                    temp = Name(generate_name('tmp'))
                    test_temps.append((temp, end))
                    return temp, test_temps
                else:
                    return end, test_temps
            case Compare(left, [cmp], [right]):
                left_exp, left_temps = self.rco_exp(left, True)
                right_exp, right_temps = self.rco_exp(right, True)
                left_temps += right_temps
                if need_atomic:
                    temp = Name(generate_name('tmp'))
                    left_temps.append((temp, Compare(left_exp, [cmp], [right_exp])))
                    return temp, left_temps
                else:
                    return Compare(left_exp, [cmp], [right_exp]), left_temps
            case Begin(body, result):
                result_exp, result_temps = self.rco_exp(result, need_atomic)
                body_stmts = []
                for s in body:
                    body_stmts += self.rco_stmt(s)
                return Begin(body_stmts, result_exp), result_temps
            case _:
                return super().rco_exp(e, need_atomic)

    def rco_stmt(self, s: stmt) -> list[stmt]:
        match s:
            case If(test, body, orelse):
                result = []
                test_exp, test_temps = self.rco_exp(test, False)
                body_stmts = [self.rco_stmt(s) for s in body]
                orelse_stmts = [self.rco_stmt(s) for s in orelse]
                for tmp, exp in test_temps:
                    result.append(Assign([tmp], exp))
                result.append(If(test_exp, body_stmts, orelse_stmts))
                return result
            case _:
                return super().rco_stmt(s)

    def remove_complex_operands(self, p: Module) -> Module:
        result = []
        match p:
            case Module(body):
                for s in body:
                    result += self.rco_stmt(s)
        print(result)
        return super().remove_complex_operands(Module(result))


    ############################################################################
    # Explicate Control
    ############################################################################

    def explicate_effect(self, e, cont, basic_blocks) -> list[stmt]:
        match e:
            case IfExp(test, body, orelse):
                # YOUR CODE HERE
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
        file_name = "test.py"
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
