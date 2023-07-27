from ast import *
from x86_ast import *
import x86_ast
from graph import *
from utils import *
from dataflow_analysis import analyze_dataflow
import copy
import type_check_Ltup
import type_check_Ctup

Binding = tuple[Name, expr]
Temporaries = list[Binding]

class Compiler:

    ###########################################################################
    # Shrink
    ###########################################################################


    ###########################################################################
    # Expose Allocation
    ###########################################################################


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
