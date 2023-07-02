# import compiler_register_allocator as compiler
import compiler
from compiler import get_fresh_tmp
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
            case BoolOp(And(), [exp1, exp2]):
                return IfExp(self.shrink_exp(exp1), self.shrink_exp(exp2), Constant(False))
            case BoolOp(Or(), [exp1, exp2]):
                return IfExp(self.shrink_exp(exp1), Constant(True), self.shrink_exp(exp2))
            case Compare(left, [cmp], [right]):
                return Compare(self.shrink_exp(left), [cmp], [self.shrink_exp(right)])
            case BinOp(left, op, right):
                return BinOp(self.shrink_exp(left), op, self.shrink_exp(right))
            case UnaryOp(op, operand):
                return UnaryOp(op, self.shrink_exp(operand))
            case IfExp(test, body, orelse):
                return IfExp(self.shrink_exp(test), self.shrink_exp(body), self.shrink_exp(orelse))
            case Call(Name(value), [args]):
                return Call(Name(value), [self.shrink_exp(args)])
            case _:
                return e

    def shrink_stmt(self, s: stmt) -> stmt:
        match s:
            case If(test, body, orelse):
                exp = self.shrink_exp(test)
                body_new = []
                for stmt in body:
                    body_new.append(self.shrink_stmt(stmt))
                orelse_new = []
                for stmt in orelse:
                    orelse_new.append(self.shrink_stmt(stmt))
                return If(exp, body_new, orelse_new)
            case Assign([lhs], rhs):
                return Assign([lhs], self.shrink_exp(rhs))
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
                if need_atomic:
                    tmp = Name(get_fresh_tmp())
                    test_temps += [(tmp, IfExp(test_exp, begin_body, begin_orelse))]
                    return tmp, test_temps
                else:
                    return IfExp(test_exp, begin_body, begin_orelse), test_temps
            case Compare(left, [cmp], [right]):
                left_exp, left_temps = self.rco_exp(left, True)
                right_exp, right_temps = self.rco_exp(right, True)
                left_temps += right_temps
                if need_atomic:
                    temp = Name(get_fresh_tmp())
                    left_temps += [(temp, Compare(left_exp, [cmp], [right_exp]))]
                    return temp, left_temps
                else:
                    return Compare(left_exp, [cmp], [right_exp]), left_temps
            case UnaryOp(Not(), operand):
                operand_exp, operand_temps = self.rco_exp(operand, True)
                if need_atomic:
                    temp = Name(get_fresh_tmp())
                    operand_temps += [(temp, UnaryOp(Not(), operand_exp))]
                    return temp, operand_temps
                else:
                    return UnaryOp(Not(), operand_exp), operand_temps
            case Call(func, [args]):
                args_exp, args_temps = self.rco_exp(args, True)
                if need_atomic:
                    temp = Name(get_fresh_tmp())
                    args_temps += [(temp, Call(func, [args_exp]))]
                    return temp, args_temps
                else:
                    return Call(func, [args_exp]), args_temps
            case _:
                return super().rco_exp(e, need_atomic)

    def rco_stmt(self, s: stmt) -> list[stmt]:
        match s:
            case If(test, body, orelse):
                test_exp, test_temps = self.rco_exp(test, False)
                body_stmts = []
                for s in body:
                    body_stmts += self.rco_stmt(s)
                orelse_stmts = []
                for s in orelse:
                    orelse_stmts += self.rco_stmt(s)
                result = []
                for name, exp in test_temps:
                    result.append(Assign([name], exp))
                result.append(If(test_exp, body_stmts, orelse_stmts))
                return result
            case IfExp(test, body, orelse):
                test_exp, test_temps = self.rco_exp(IfExp(test, body, orelse), False)
                result = []
                for name, exp in test_temps:
                    result.append(Assign([name], exp))
                result.append(Expr(test_exp))
                return result
            case _:
                return super().rco_stmt(s)

    ############################################################################
    # Explicate Control
    ############################################################################

    def explicate_effect(self, e, cont, basic_blocks) -> list[stmt]:
        match e:
            case IfExp(test, body, orelse):
                continuation = create_block(cont, basic_blocks)
                new_body = self.explicate_effect(body, continuation, basic_blocks)
                new_orelse = self.explicate_effect(orelse, continuation, basic_blocks)
                return self.explicate_pred(test, new_body, new_orelse, {})
            case Begin(body, result):
                new_body = self.explicate_effect(result, cont, basic_blocks)
                for s in reversed(body):
                    new_body = self.explicate_stmt(s, new_body, basic_blocks)
                return new_body
            case _:
                return [Expr(e)] + cont

    def explicate_assign(self, rhs, lhs, cont, basic_blocks) -> list[stmt]:
        match rhs:
            case IfExp(test, body, orelse):
                continuation = create_block(cont, basic_blocks)
                new_body = self.explicate_assign(body, lhs, [], basic_blocks) + continuation
                new_orelse = self.explicate_assign(orelse, lhs, [], basic_blocks) + continuation
                return self.explicate_pred(test, new_body, new_orelse, basic_blocks)
            case Begin(body, result):
                result = self.explicate_assign(result, lhs, cont, basic_blocks)
                for s in reversed(body):
                    result = self.explicate_stmt(s, result, basic_blocks)
                return result
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
                then_label = create_block(thn, basic_blocks)
                else_label = create_block(els, basic_blocks)
                new_body = self.explicate_pred(body, then_label, else_label, basic_blocks)
                new_orelse = self.explicate_pred(orelse, then_label, else_label, basic_blocks)
                return self.explicate_pred(test, new_body, new_orelse, basic_blocks)
            case Begin(body, result):
                result_new = []
                for s in reversed(body):
                    result_new = self.explicate_stmt(s, result, basic_blocks)
                return result_new + self.explicate_pred(result, thn, els, basic_blocks)
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
                continuation = create_block(cont, basic_blocks)
                new_body = self.explicate_effect(body, continuation, basic_blocks)
                new_orelse = self.explicate_effect(orelse, continuation, basic_blocks)
                return self.explicate_pred(test, new_body, new_orelse, basic_blocks)
            case If(test, body, orelse):
                continuation = create_block(cont, basic_blocks)
                new_body = []
                for s in reversed(body):
                    new_body = self.explicate_stmt(s, continuation, basic_blocks)
                new_orelse = []
                for s in reversed(orelse):
                    new_orelse = self.explicate_stmt(s, continuation, basic_blocks)
                return self.explicate_pred(test, new_body, new_orelse, basic_blocks)
            case _:
                raise Exception(f"Unexpected statement: {s}")

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
