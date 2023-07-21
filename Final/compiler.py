import ast
from ast import *
from utils import *
from x86_ast import *
import os

Binding = tuple[Name, expr]
Temporaries = list[Binding]

get_fresh_tmp = lambda: generate_name('tmp')


class Compiler:
    def __init__(self):
        self.stack_size = 0

    ############################################################################
    # Remove Complex Operands
    ############################################################################

    def tmps_to_stmts(self, tmps: Temporaries) -> list[stmt]:
        result = []
        for tmp in tmps:
            lhs, rhs = tmp
            result.append(Assign([lhs], rhs))
        return result

    def rco_exp(self, e: expr, needs_to_be_atomic: bool) -> tuple[expr, Temporaries]:
        match e:
            case Name(_) | Constant(_):
                return (e, [])
            case Call(Name('input_int'), []):
                if needs_to_be_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (Name(fresh_tmp), [(Name(fresh_tmp), e)])
                return (e, [])
            case UnaryOp(USub(), e1):
                atm, tmps = self.rco_exp(e1, True)
                if needs_to_be_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmps + [(Name(fresh_tmp), UnaryOp(USub(), atm))],
                    )
                return (UnaryOp(USub(), atm), tmps)
            case BinOp(e1, op, e2):
                atm1, tmps1 = self.rco_exp(e1, True)
                atm2, tmps2 = self.rco_exp(e2, True)
                if needs_to_be_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmps1 + tmps2 + [(Name(fresh_tmp), BinOp(atm1, op, atm2))],
                    )
                return (BinOp(atm1, op, atm2), tmps1 + tmps2)

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

    def remove_complex_operands(self, p: Module) -> Module:
        match p:
            case Module(body):
                new_body = []
                for stm in body:
                    new_body += self.rco_stmt(stm)
                return Module(new_body)

    ############################################################################
    # Select Instructions
    ############################################################################

    def select_arg(self, e: expr) -> arg:
        match e:
            case Constant(n):
                return Immediate(n)
            case Name(v):
                return Variable(v)

    def select_assign(self, s: stmt) -> list[instr]:
        result = []
        match s:
            # var = atm + atm
            case Assign([Name(var)], BinOp(atm1, Add(), atm2)):
                arg1 = self.select_arg(atm1)
                arg2 = self.select_arg(atm2)
                lhs = Variable(var)
                # var = var + atm
                if arg1 == lhs:
                    result.append(Instr('addq', [arg2, lhs]))
                # var = atm + var
                elif arg2 == lhs:
                    result.append(Instr('addq', [arg1, lhs]))
                else:
                    result.append(Instr('movq', [arg1, lhs]))
                    result.append(Instr('addq', [arg2, lhs]))
            # var = atm - atm
            case Assign([Name(var)], BinOp(atm1, Sub(), atm2)):
                arg1 = self.select_arg(atm1)
                arg2 = self.select_arg(atm2)
                lhs = Variable(var)
                # var = var - atm
                if arg1 == lhs:
                    result.append(Instr('subq', [arg2, lhs]))
                # var = atm - var
                elif arg2 == lhs:
                    result.append(Instr('negq', [lhs]))
                    result.append(Instr('addq', [arg1, lhs]))
                else:
                    result.append(Instr('movq', [arg1, lhs]))
                    result.append(Instr('subq', [arg2, lhs]))
            # var = - atm
            case Assign([Name(var)], UnaryOp(USub(), atm)):
                arg = self.select_arg(atm)
                result.append(Instr('movq', [arg, Variable(var)]))
                result.append(Instr('negq', [Variable(var)]))
            # var = input_int
            case Assign([Name(var)], Call(Name('input_int'), [])):
                result.append(Callq(label_name('read_int'), 0))
                result.append(Instr('movq', [Reg('rax'), Variable(var)]))
            # var = var | var = int
            case Assign([Name(var)], atm):
                arg = self.select_arg(atm)
                result.append(Instr('movq', [arg, Variable(var)]))

        return result

    def select_stmt(self, s: stmt) -> list[instr]:
        result = []
        match s:
            # var = exp
            case Assign([Name(var)], exp):
                return self.select_assign(s)
            # print(atm)
            case Expr(Call(Name('print'), [atm])):
                arg = self.select_arg(atm)
                return [
                    Instr('movq', [arg, Reg('rdi')]),
                    Callq(label_name('print_int'), 1),
                ]
            # input_int()
            case Expr(Call(Name('input_int'), [])):
                return [Callq(label_name('read_int'), 0)]

    def select_instructions(self, p: Module) -> X86Program:
        match p:
            case Module(body):
                new_body = []
                for stm in body:
                    new_body += self.select_stmt(stm)
                return X86Program(new_body)

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes_arg(self, a: arg, home: dict[Variable, arg]) -> arg:
        match a:
            case Variable(_):
                if a not in home:
                    self.stack_size += 8
                    home[a] = Deref('rbp', -self.stack_size)
                return home[a]
            case _:
                return a

    def assign_homes_instr(self, i: instr, home: dict[Variable, arg]) -> instr:
        match i:
            case Instr(op, [arg1, arg2]):
                return Instr(
                    op,
                    [
                        self.assign_homes_arg(arg1, home),
                        self.assign_homes_arg(arg2, home),
                    ],
                )
            case Instr(op, [arg1]):
                return Instr(op, [self.assign_homes_arg(arg1, home)])
            case Callq('read_int', 0) | Callq('print_int', 1):
                return i
            case _:
                return i

    def assign_homes_instrs(
        self, ss: list[instr], home: dict[Variable, arg]
    ) -> list[instr]:
        result = []
        for i in ss:
            result.append(self.assign_homes_instr(i, home))
        return result

    def assign_homes(self, p: X86Program) -> X86Program:
        self.stack_size = 0
        home = {}
        return X86Program(self.assign_homes_instrs(p.body, home))

    ############################################################################
    # Patch Instructions
    ############################################################################

    def patch_instr(self, i: instr) -> list[instr]:
        match i:
            case Instr('movq', [arg1, arg2]) if arg1 == arg2:
                return []
            case Instr(op, [Deref(reg, offset), Deref(reg2, offset2)]):
                return [
                    Instr('movq', [Deref(reg, offset), Reg('rax')]),
                    Instr(op, [Reg('rax'), Deref(reg2, offset2)]),
                ]
            case _:
                return [i]

    def patch_instrs(self, instrs: list[instr]) -> list[instr]:
        result = []
        for i in instrs:
            result += self.patch_instr(i)
        return result

    def patch_instructions(self, p: X86Program) -> X86Program:
        return X86Program(self.patch_instrs(p.body))

    ############################################################################
    # Prelude & Conclusion
    ############################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        new_body = []
        adjust_stack_size = (
            self.stack_size if self.stack_size % 16 == 0 else self.stack_size + 8
        )

        prelude = [
            Instr("pushq", [Reg("rbp")]),
            Instr("movq", [Reg("rsp"), Reg("rbp")]),
        ]
        if adjust_stack_size > 0:
            prelude.append(Instr('subq', [Immediate(adjust_stack_size), Reg('rsp')]))

        new_body.extend(prelude)
        new_body.extend(p.body)

        conclusion = [Instr('popq', [Reg('rbp')]), Instr('retq', [])]
        if adjust_stack_size > 0:
            conclusion.insert(
                0, Instr('addq', [Immediate(adjust_stack_size), Reg('rsp')])
            )

        new_body.extend(conclusion)
        return X86Program(new_body)

    ##################################################
    # Compiler
    ##################################################

    def compile(self, s: str, logging=False) -> X86Program:
        compiler_passes = {
            'remove complex operands': self.remove_complex_operands,
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
