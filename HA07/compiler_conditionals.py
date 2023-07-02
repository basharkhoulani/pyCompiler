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
            case Call(func, [args]):
                return Call(func, [self.shrink_exp(args)])
            case _:
                return e

    def shrink_stmt(self, s: stmt) -> stmt:
        match s:
            case If(test, body, orelse):
                exp = self.shrink_exp(test)
                body_new = [self.shrink_stmt(stmt) for stmt in body]
                orelse_new = [self.shrink_stmt(stmt) for stmt in orelse]
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
                out_test = self.rco_exp(test, False)
                out_body = self.rco_exp(body, False)
                out_orelse = self.rco_exp(orelse, False)

                begin_test = []
                begin_body = []
                begin_orelse = []
                for name, exp in out_test[1]:
                    begin_test.append(Assign([name], exp))
                for name, exp in out_body[1]:
                    begin_body.append(Assign([name], exp))
                for name, exp in out_orelse[1]:
                    begin_orelse.append(Assign([name], exp))

                result = IfExp(Begin(begin_test, out_test[0]), Begin(begin_body, out_body[0]), Begin(begin_orelse, out_orelse[0])), []

            case Compare(left, [cmp], [right]):
                out_left = self.rco_exp(left, True)
                out_right = self.rco_exp(right, True)
                result = Compare(out_left[0], [cmp], [out_right[0]]), out_left[1] + out_right[1]
            case UnaryOp(Not(), operand):
                out = self.rco_exp(operand, True)
                result = UnaryOp(Not(), out[0]), out[1]
            case _:
                return super().rco_exp(e, need_atomic)

        if need_atomic:
            tmp = get_fresh_tmp()
            result = (Name(tmp), result[1] + [(Name(tmp), result[0])])

        return result

    def rco_stmt(self, s: stmt) -> list[stmt]:
        match s:
            case If(test, body, orelse):
                test_exp, test_temps = self.rco_exp(test, False)
                body_stmts = []
                for s in body:
                    body_stmts.extend(self.rco_stmt(s))
                orelse_stmts = []
                for s in orelse:
                    orelse_stmts.extend(self.rco_stmt(s))
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
                return self.explicate_stmt_list(body, new_body, basic_blocks)
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
                return self.explicate_stmt_list(body, result, basic_blocks)
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
                result_new = self.explicate_stmt_list(body, [], basic_blocks)
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
                new_body = self.explicate_stmt_list(body, continuation, basic_blocks)
                new_orelse = self.explicate_stmt_list(orelse, continuation, basic_blocks)
                return self.explicate_pred(test, new_body, new_orelse, basic_blocks)
            case _:
                raise Exception(f"Unexpected statement: {s}")

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
