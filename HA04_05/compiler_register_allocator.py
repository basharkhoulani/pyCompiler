import compiler
from graph import UndirectedAdjList
from ast import *
from x86_ast import *
from os import sys

class Compiler(compiler.Compiler):
    
    def __init__(self):
        self.registers = {Reg('rax'), Reg('rcx'), Reg('rdx'), Reg('rsi'), Reg('rdi'), Reg('r8'), Reg('r9'), Reg('r10'), Reg('r11')}
    

    ###########################################################################
    # Uncover Live
    ###########################################################################

    def read_vars(self, i: instr) -> set[location]:
        result: set[location] = set()
        match i:
            case Instr('movq', [a, b]): result = {a}
            case Instr('addq', [a, b]): result = {a, b}
            case Instr('subq', [a, b]): result = {a, b}
            case Instr('negq', [a]):    result = {a}
            case Instr('pushq', [a]):   result = {a}
            case Callq(_, n):           result = {Reg('rdi')} if n == 1 else set()
            case _:                     result = set()
        return set([item for item in result if not isinstance(item, Immediate)])

    def write_vars(self, i: instr) -> set[location]:
        result: set[location] = set()
        match i:
            case Instr('movq', [a, b]): result = {b}
            case Instr('addq', [a, b]): result = {b} 
            case Instr('subq', [a, b]): result = {b}
            case Instr('negq', [a]):    result = {a}
            case Instr('popq', [a]):    result = {a}
            case Callq(_, n):           result = {Reg('rax')}
            case _:                     result = set()
        return set([item for item in result if not isinstance(item, Immediate)])

    def uncover_live(self, p: X86Program) -> dict[instr, set[location]]:
        result: dict[instr, set[location]] = {}
        
        l_after: set[location] = set()
        l_before: set[location] = set()
        
        for inst in reversed(p.body):           
            l_after = l_before
            l_before = (l_after - self.write_vars(inst)) | self.read_vars(inst)
            
            result[inst] = l_before
        
        ret_result: dict[instr, set[location]] = {}
        for (k,v) in reversed(result.items()):
            ret_result[k] = v
            
        return ret_result
        

    ############################################################################
    # Build Interference
    ############################################################################

    @staticmethod
    def lbl(v: location) -> str:
        match v:
            case Reg(r): return r
            case _:      return str(v)
            
    def build_interference(self, p: X86Program,
                           live_after: dict[instr, set[location]]) -> UndirectedAdjList:
        result: UndirectedAdjList = UndirectedAdjList(vertex_label=self.lbl)
               
        for (k,vs) in live_after.items():
            match k:
                case Instr('movq', [s, d]):
                    for v in vs:
                        if v != s and v != d and not result.has_edge(d, v):
                            result.add_edge(d, v)
                case Instr(_, [s, d]):
                    for v in self.write_vars(k):
                        for d in vs:
                            if v != d and not result.has_edge(d, v):
                                result.add_edge(d, v)
                case Instr(_, [d]):
                    for v in self.write_vars(k):
                        for d in vs:
                            if v != d and not result.has_edge(d, v):
                                result.add_edge(d, v)
        
        return result

    ############################################################################
    # Allocate Registers
    ############################################################################
    
    def find_vertex(self, graph: UndirectedAdjList, var_count: int) -> location:
        for vertex in graph.vertices():
            if len(graph.adjacent(vertex)) < var_count:
                return vertex
        return None
    
    def color_graph_step(self, vertex: location, neighbours: dict[location, list[location]], graph: UndirectedAdjList,
                         variables: set[Reg], stack: list[Reg], coloring: dict[Deref, Reg]) -> dict[Deref, Reg]:
        if vertex is None:
            return coloring
        
        stack.append(vertex)
        graph.remove_vertex(vertex)
        
        result = self.color_graph_step(self.find_vertex(graph, len(variables)), neighbours, graph, variables, stack, coloring)
        
        
        if isinstance(vertex, Reg):
            return result
        
        for color in variables:
            is_color_available = True
            for neighbour in neighbours[vertex]:
                neighbour_color = result.get(neighbour)
                if neighbour_color is not None and neighbour_color == color:
                    is_color_available = False
                    break
            if is_color_available:
                result[vertex] = color
                break
        
        return result

    def color_graph(self, graph: UndirectedAdjList, variables: set[Reg]) -> dict[Deref, Reg]:
        stack: list[Reg] = list()
        coloring: dict[Deref, Reg] = dict()
        neighbours: dict[location, list[location]] = dict()
        for vertex in graph.vertices():
            neighbours[vertex] = graph.adjacent(vertex)
        return self.color_graph_step(self.find_vertex(graph, len(variables)), neighbours, graph, variables, stack, coloring)

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes(self, p: X86Program) -> X86Program:
        result: list[instr] = []
        live_after: dict[instr, set[location]] = self.uncover_live(p)
        interference: UndirectedAdjList = self.build_interference(p, live_after)
        coloring: dict[Deref, Reg] = self.color_graph(interference, self.registers)
        
        for inst in p.body:
            match inst:
                case Instr(inst, [s, d]):
                    result.append(Instr(inst, [coloring.get(s, s), coloring.get(d, d)]))
                case Instr(inst, [d]):
                    result.append(Instr(inst, [coloring.get(d, d)]))
                case other:
                    result.append(other)
                    
        return X86Program(result)
                    

    ###########################################################################
    # Patch Instructions
    ###########################################################################

    def patch_instructions(self, p: X86Program) -> X86Program:
        return p

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
