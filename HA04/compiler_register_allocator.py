import compiler
from graph import UndirectedAdjList
from ast import *
from x86_ast import *

class Compiler(compiler.Compiler):

    ###########################################################################
    # Uncover Live
    ###########################################################################

    def remove_immediate_and_regs(self, a : set[location]) -> set[location]:
        out = set()
        for x in a:
            match x:
                case Immediate(v):
                    None
                case Reg(v):
                    out.add(x)
                case _:
                    out.add(x)

        return out


    def read_vars(self, i: instr) -> set[location]:
        match i:
            case Instr(name, args):
                if name=="movq":
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

            helper = self.remove_immediate_and_regs(self.write_vars(p.body[i]))
            for x in helper:
                beforeKp1.discard(x)

            helper = self.remove_immediate_and_regs(self.read_vars(p.body[i]))
            beforeKp1.update(helper)
            
            #collision handling
            if p.body[i] in out:
                out[p.body[i]].update(beforeKp1)
            else:
                out[p.body[i]] = beforeKp1

            beforeKp1 = beforeKp1.copy()

        return out    


    ############################################################################
    # Build Interference
    ############################################################################

    def build_interference(self, p: X86Program, live_after: dict[instr, set[location]]) -> UndirectedAdjList:
        edges = []

        for instr in p.body:
            l_after = live_after[instr]
            
            match instr:
                case Instr(name, args):
                    if name=="movq":
                        #edge case
                        s = args[0]
                        d = args[1]

                        for v in l_after:
                            if s != v and d != v:
                                edges.append((d, v))

                        continue
                
            #alternate case
            v_list = self.remove_immediate_and_regs( self.write_vars(instr) )
            for v in v_list:
                for d in l_after:
                    if d != v:
                        edges.append((v, d))
        
        return UndirectedAdjList(edges)
        



    ############################################################################
    # Allocate Registers
    ############################################################################
    reg_count = 8
    def index_to_reg(self, i : int) -> Reg:
        match i:
            case 0:
                return Reg("rdi")
            case 1:
                return Reg("rsi")
            case 2:
                return Reg("rdx")
            case 3:
                return Reg("rcx")
            case 4:
                return Reg("r8")
            case 5:
                return Reg("r9")
            case 6:
                return Reg("r10")
            case 7:
                return Reg("r11")
        raise Exception("invalid register index")


    def color_graph(self, graph: UndirectedAdjList, variables: set[location]) -> dict[Variable, arg]:
        stack = []

        #fill stack
        while (graph.num_vertices() - len(stack)) != 1:
            found = False
            for v in graph.vertices():
                if not (v in stack):
                    edgeCount = 0
                    for e in graph.out_edges(v):
                        edgeCount = edgeCount + 1

                    if edgeCount < self.reg_count:
                        stack.append(v)
                        found = True
                        break

            #we can't map a new variable we need to put one on the stack
            if not found:
                raise Exception("can't map a variable to stack")
                
        #color last one
        reg_index_map = {}
        for v in graph.vertices():
                if not (v in stack):
                    reg_index_map[v] = 0
                    break
        
        #process stack
        stack = stack[::-1]
        for x in stack:
            sucessPaint = False
            for try_index in range(0, self.reg_count):
                #try to color
                edges = graph.adjacent(x)
                collision = False
                for neightbour in edges:
                    if neightbour in reg_index_map:
                        if try_index == reg_index_map[neightbour]:
                            collision = True
                            break

                if not collision:
                    sucessPaint = True
                    reg_index_map[x] = try_index
            
            if not sucessPaint:
                raise Exception("Error during coloring")

        #translate to regs
        out_dict = {}
        for var in reg_index_map:
            out_dict[var.id] = self.index_to_reg(reg_index_map[var])
        return out_dict

    ############################################################################
    # Assign Homes
    ############################################################################
    def assign_homes_instr(self, i: instr,
                           home: dict[Variable, arg]) -> instr:
        match i:
            case Instr("movq", [Variable(lhs), Variable(rhs)]):
                #handle all edge cases
                if lhs in home and not rhs in home:
                   home[rhs] = home[lhs]

                return Instr("movq", [
                    self.assign_homes_arg(Variable(lhs), home), 
                    self.assign_homes_arg(Variable(rhs), home)
                ])
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

    def pretty(self, d, indent=0):
        for key, value in d.items():
            print('\t' * indent + str(key))
            if isinstance(value, dict):
                self.pretty(value, indent+1)
            else:
                print('\t' * (indent+1) + str(value))

    def assign_homes(self, p: X86Program) -> X86Program:
        uncover_live_data = self.uncover_live(p)
        self.pretty(uncover_live_data)

        graph = self.build_interference(p, uncover_live_data)
        reg_mapping = self.color_graph(graph, set())

        out = []
        for instr in p.body:
            out.append(self.assign_homes_instr(instr, reg_mapping))

        return X86Program(out)

    ###########################################################################
    # Patch Instructions
    ###########################################################################

    def patch_instructions(self, p: X86Program) -> X86Program:
        return p
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
