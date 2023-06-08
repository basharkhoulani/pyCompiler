import compiler
from graph import UndirectedAdjList
from ast import *
from x86_ast import *

class Compiler(compiler.Compiler):

    ###########################################################################
    # Uncover Live
    ###########################################################################

    def read_vars(self, i: instr) -> set[location]:
        # YOUR CODE HERE
        pass

    def write_vars(self, i: instr) -> set[location]:
        # YOUR CODE HERE
        pass

    def uncover_live(self, p: X86Program) -> dict[instr, set[location]]:
        # YOUR CODE HERE
        pass

    ############################################################################
    # Build Interference
    ############################################################################

    def build_interference(self, p: X86Program,
                           live_after: dict[instr, set[location]]) -> UndirectedAdjList:
        # YOUR CODE HERE
        pass

    ############################################################################
    # Allocate Registers
    ############################################################################

    def color_graph(self, graph: UndirectedAdjList,
                    variables: set[location]) -> dict[Variable, arg]:
        # YOUR CODE HERE
        pass

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes(self, p: X86Program) -> X86Program:
        # YOUR CODE HERE
        pass

    ###########################################################################
    # Patch Instructions
    ###########################################################################

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
