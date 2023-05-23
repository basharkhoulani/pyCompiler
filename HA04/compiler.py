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

    def rco_exp(self, e: expr, needs_to_be_atomic: bool) -> tuple[expr, Temporaries]:
        # YOUR CODE HERE
        pass

    def rco_stmt(self, s: stmt) -> list[stmt]:
        # YOUR CODE HERE
        pass

    def remove_complex_operands(self, p: Module) -> Module:
        # YOUR CODE HERE
        pass

    ############################################################################
    # Select Instructions
    ############################################################################

    def select_arg(self, e: expr) -> arg:
        # YOUR CODE HERE
        pass

    def select_stmt(self, s: stmt) -> list[instr]:
        # YOUR CODE HERE
        pass

    def select_instructions(self, p: Module) -> X86Program:
        # YOUR CODE HERE
        pass

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes_arg(self, a: arg, home: dict[Variable, arg]) -> arg:
        # YOUR CODE HERE
        pass

    def assign_homes_instr(self, i: instr,
                           home: dict[Variable, arg]) -> instr:
        # YOUR CODE HERE
        pass

    def assign_homes_instrs(self, s: list[instr],
                            home: dict[Variable, arg]) -> list[instr]:
        # YOUR CODE HERE
        pass

    def assign_homes(self, p: X86Program) -> X86Program:
         # YOUR CODE HERE
         pass

    ############################################################################
    # Patch Instructions
    ############################################################################

    def patch_instr(self, i: instr) -> list[instr]:
        # YOUR CODE HERE
        pass

    def patch_instrs(self, s: list[instr]) -> list[instr]:
        # YOUR CODE HERE
        pass

    def patch_instructions(self, p: X86Program) -> X86Program:
         # YOUR CODE HERE
         pass

    ############################################################################
    # Prelude & Conclusion
    ############################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        new_body = []
        adjust_stack_size = self.stack_size if self.stack_size % 16 == 0 else self.stack_size + 8

        prelude = [Instr("pushq", [Reg("rbp")]), Instr("movq", [Reg("rsp"), Reg("rbp")])]
        if adjust_stack_size > 0:
            prelude.append(Instr('subq', [Immediate(adjust_stack_size), Reg('rsp')]))

        new_body.extend(prelude)
        new_body.extend(p.body)

        conclusion = [Instr('popq', [Reg('rbp')]), Instr('retq', [])]
        if adjust_stack_size > 0:
            conclusion.insert(0, Instr('addq', [Immediate(adjust_stack_size), Reg('rsp')]))

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
                print('Error during compilation! **************************************************')
                import traceback
                traceback.print_exception(*sys.exc_info())
