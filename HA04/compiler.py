import ast
from ast import *
import subprocess
from utils import *
from x86_ast import *
import os

Binding = tuple[Name, expr]
Temporaries = list[Binding]


def get_fresh_tmp(): return generate_name('tmp')


class Compiler:
    def __init__(self):
        self.stack_size = 0

    ############################################################################
    # Remove Complex Operands
    ############################################################################

    def rco_exp(self, e: expr, atomic: bool) -> tuple[expr, Temporaries]:
        result: tuple[expr, Temporaries] = (None, [])
        match e:
            case Constant(n):
                return (Constant(n), [])
            case Name(name):
                return (Name(name), [])
            case UnaryOp(op, rhs):
                rhs = self.rco_exp(rhs, True)
                result = (UnaryOp(op, rhs[0]), rhs[1])
            case BinOp(lhs, op, rhs):
                nlhs = self.rco_exp(lhs, True)
                nrhs = self.rco_exp(rhs, True)
                result = (BinOp(nlhs[0], op, nrhs[0]), nlhs[1] + nrhs[1])
            case Call(Name(func), []):
                result = (Call(Name(func), []), [])
            case _:
                raise Exception("Unknown expression type: " + str(e))

        if atomic:
            tmp = get_fresh_tmp()
            result = (Name(tmp), result[1] + [(Name(tmp), result[0])])

        return result

    def rco_stmt(self, s: stmt) -> list[stmt]:
        schema: tuple[expr, Temporaries]
        match s:
            case Expr(Call(Name(name), [expr])): schema = self.rco_call(name, expr)
            case Assign([Name(name)], expr): schema = self.rco_assign(name, expr)
            case Expr(expr): schema = self.rco_exp(expr, False)
            case _: raise Exception("Unknown statement type: " + str(s))

        result: list[stmt] = []
        for temp in schema[1]:
            result.append(Assign([temp[0]], temp[1]))
        result.append(schema[0])
        return result

    def rco_call(self, name: str, expr: expr) -> tuple[expr, Temporaries]:
        schema = self.rco_exp(expr, True)
        schema = (Expr(Call(Name(name), [schema[0]])), schema[1])
        return schema

    def rco_assign(self, name: str, expr: expr) -> tuple[expr, Temporaries]:
        schema = self.rco_exp(expr, False)
        schema = (Assign([Name(name)], schema[0]), schema[1])
        return schema

    def remove_complex_operands(self, p: Module) -> Module:
        module = Module()
        module.body = []
        for stmt in p.body:
            module.body.extend(self.rco_stmt(stmt))
        return module

    ############################################################################
    # Select Instructions
    ############################################################################

    def select_arg(self, e: expr) -> arg:
        match e:
            case Constant(n): return Immediate(n)
            case Name(name): return Variable(name)
            case _: raise Exception("Unknown argument type: " + str(e))

    def select_stmt(self, s: stmt) -> list[instr]:
        match s:
            case Expr(Call(Name('print'), [exp])): return self.select_call('print_int', exp)
            case Expr(Call(Name(fn), [exp])): return self.select_call(fn, exp)
            case Assign([Name(name)], exp): return self.select_assign(name, exp)
            case _: raise Exception("Unknown statement type: " + str(s))

    def select_call(self, name: str, exp: expr) -> list[instr]:
        result: list[instr] = [
            Instr("movq", [self.select_arg(exp), Reg("rdi")]),
            Callq(name, 1)
        ]
        return result

    def select_assign(self, name: str, exp: expr) -> list[instr]:
        match exp:
            case Constant(n):
                return [Instr("movq", [Immediate(n), Variable(name)])]
            case Name(name2):
                return [Instr("movq", [Variable(name2), Variable(name)])]
            case UnaryOp(USub(), Constant(n)):
                return [
                    Instr("movq", [self.select_arg(Constant(n)), Variable(name)]),
                    Instr("negq", [Variable(name)])
                ]
            case UnaryOp(USub(), rhs):
                return [
                    Instr("movq", [self.select_arg(rhs), Variable(name)]),
                    Instr("negq", [Variable(name)])
                ]
            case Call(Name('input_int'), []):
                return [Callq('read_int', 0), Instr("movq", [Reg("rax"), Variable(name)])]
            case Call(Name(fn), []):
                return [Callq(fn, 0), Instr("movq", [Reg("rax"), Variable(name)])]
            case BinOp(lhs, Add(), rhs):
                tmp = get_fresh_tmp()
                return [
                    Instr("movq", [self.select_arg(lhs), Variable(tmp)]),
                    Instr("addq", [self.select_arg(rhs), Variable(tmp)]),
                    Instr("movq", [Variable(tmp), Variable(name)])
                ]
            case BinOp(lhs, Sub(), rhs):
                tmp = get_fresh_tmp()
                return [
                    Instr("movq", [self.select_arg(lhs), Variable(tmp)]),
                    Instr("subq", [self.select_arg(rhs), Variable(tmp)]),
                    Instr("movq", [Variable(tmp), Variable(name)])
                ]
            case _:
                raise Exception("Unknown expression type: " + str(exp))

    def select_instructions(self, p: Module) -> X86Program:
        list: list[instr] = []
        for stmt in p.body:
            list.extend(self.select_stmt(stmt))
        return X86Program(list)

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes_arg(self, a: arg, home: dict[Variable, arg]) -> arg:
        match a:
            case Variable(name):
                if name in home:
                    return home[name]
                else:
                    self.stack_size += 8
                    arg = Deref('rbp', -self.stack_size)
                    home[name] = arg
                    return arg
            case Immediate(n): 
                return Immediate(n)
            case Reg(name): 
                return Reg(name)

        raise Exception("Unknown argument type: " + str(a))

    def assign_homes_instr(self, i: instr,
                           home: dict[Variable, arg]) -> instr:
        match i:
            case Instr(inst, [lhs, rhs]):
                return Instr(inst, [
                    self.assign_homes_arg(lhs, home), 
                    self.assign_homes_arg(rhs, home)
                ])
            case Instr(inst, [arg]):
                return Instr(inst, [
                    self.assign_homes_arg(arg, home)
                ])
            case Callq(name, n):
                return Callq(name, n)
            case _:
                raise Exception("Unknown instruction type: " + str(i))

    def assign_homes_instrs(self, s: list[instr],
                            home: dict[Variable, arg]) -> list[instr]:
        return [self.assign_homes_instr(i, home) for i in s]

    def assign_homes(self, p: X86Program) -> X86Program:
        self.stack_size = 0
        p.body = self.assign_homes_instrs(p.body, {})
        return p

    ############################################################################
    # Patch Instructions
    ############################################################################

    def patch_instr(self, i: instr) -> list[instr]:
        result: list[instr] = []
        match i:
            case Instr('movq', [Reg(a), Reg(b)]):
                if a == b:
                    return []
            case Instr(inst, [Deref(lhs, n), Deref(rhs, m)]):
                if inst == 'movq' and lhs == rhs and n == m:
                    return []
                result.append(Instr('movq', [Deref(lhs, n), Reg('rax')]))
                result.append(Instr(inst, [Reg('rax'), Deref(rhs, m)]))
            case i:
                result.append(i)
        return result

    def patch_instrs(self, s: list[instr]) -> list[instr]:
        result: list[instr] = []
        for i in s:
            result.extend(self.patch_instr(i))
        return result

    def patch_instructions(self, p: X86Program) -> X86Program:
        p.body = self.patch_instrs(p.body)
        return p

    ############################################################################
    # Prelude & Conclusion
    ############################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        new_body = []
        adjust_stack_size = self.stack_size if self.stack_size % 16 == 0 else self.stack_size + 8

        prelude = [Instr("pushq", [Reg("rbp")]), Instr(
           "movq", [Reg("rsp"), Reg("rbp")])]
        if adjust_stack_size > 0:
            prelude.append(
               Instr('subq', [Immediate(adjust_stack_size), Reg('rsp')]))

        new_body.extend(prelude)
        new_body.extend(p.body)

        conclusion = [Instr('popq', [Reg('rbp')]), Instr('retq', [])]
        if adjust_stack_size > 0:
            conclusion.insert(
               0, Instr('addq', [Immediate(adjust_stack_size), Reg('rsp')]))

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
                   'Error during compilation! **************************************************')
                import traceback
                traceback.print_exception(*sys.exc_info())
