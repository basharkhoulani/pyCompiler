import compiler
from graph import UndirectedAdjList
from ast import *
from x86_ast import *

class Compiler(compiler.Compiler):

    ###########################################################################
    # Uncover Live
    ###########################################################################

    def read_vars(self, i: instr) -> set[location]:
        match i :
            case Instr(name, args):
                if name =="moveq":
                    return set([args[0]])

                if len(args) == 2:
                    return set([args[0], args[1]])
                return set([args[0]])
        return set()

    def write_vars(self, i: instr) -> set[location]:
        match i:
            case Instr(name, args):
                return set([args[-1]])
        return set()


    def uncover_live(self, p: X86Program) -> dict[instr, set[location]]:
        out = {}

        beforeKp1 = set()
        for i in range(len(p.body) - 1, -1, -1):

            for x in self.remove_immediate_and_regs(self.write_vars(p.body[i])):
                beforeKp1.discard(x)

            beforeKp1.update(self.remove_immediate_and_regs(self.read_vars(p.body[i])))
            
            if p.body[i] in out:
                out[p.body[i]].update(beforeKp1)
            else:
                out[p.body[i]] = beforeKp1

            beforeKp1 = beforeKp1.copy()

        return out

    ############################################################################
    # Build Interference
    ############################################################################

    def build_interference(self, p: X86Program,
                           live_after: dict[instr, set[location]]) -> UndirectedAdjList:
        edges = []

        for instr in p.body:
            l_after = live_after[instr]
            
            match instr:
                case Instr(name, args):
                    if name=="movq":
                        
                        s = args[0]
                        d = args[1]

                        for v in l_after:
                            if s != v and d != v:
                                edges.append((d, v))

                        continue
                
            
            v_list = self.remove_immediate_and_regs( self.write_vars(instr) )
            for v in v_list:
                for d in l_after:
                    if d != v:
                        edges.append((v, d))
        
        return UndirectedAdjList(edges)


    ############################################################################
    # Allocate Registers
    ############################################################################

    def color_graph(self, graph: UndirectedAdjList,
                    variables: set[location]) -> dict[Variable, arg]:
        
        pass

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes(self, p: X86Program) -> X86Program:
        
        pass

    ###########################################################################
    # Patch Instructions
    ###########################################################################

    def patch_instructions(self, p: X86Program) -> X86Program:
        
        pass

    ###########################################################################
    # Prelude & Conclusion
    ###########################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
       
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
