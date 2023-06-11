import random
import compiler
from graph import UndirectedAdjList
from ast import *
from x86_ast import *
from os import sys
import copy

class Compiler(compiler.Compiler):
    
    def __init__(self):
        self.registers = {
            # rdi and rax cause problems when used as temporary registers
            # because they interfere with function calls and returns
            
            # Reg('rdi'), Reg('rax'), 
            Reg('rcx'), Reg('rdx'), Reg('rsi'), Reg('r8'), Reg('r9'), Reg('r10'), Reg('r11')
        }
        self.reduced_locations = 0
        self.stack_size = 0
        self.save_restore_registers = True
        self.use_spilling = True
        self.spill_method = self.spill_most_neighbours
    

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
            
            result[inst] = l_after
        
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
                # handle rdi and rax with care
                case Callq(_,_):
                    for v in vs:
                        if v != Reg('rdi') and v != Reg('rax'):
                            if not result.has_edge(Reg('rax'), v):
                                result.add_edge(Reg('rax'), v)
                            if not result.has_edge(Reg('rdi'), v):
                                result.add_edge(Reg('rdi'), v)
                case Instr('movq', [s, d]):
                    if not isinstance(s, Immediate):
                        result.add_vertex(s)
                    if not isinstance(d, Immediate):
                        result.add_vertex(d)
                    for v in vs:
                        if v != s and v != d and not result.has_edge(d, v):
                            result.add_edge(d, v)
                case Instr(_, [_, d]):
                    if not isinstance(d, Immediate):
                        result.add_vertex(d)
                    for v in self.write_vars(k):
                        for d in vs:
                            if v != d and not result.has_edge(d, v):
                                result.add_edge(d, v)
                case Instr(_, [d]):
                    if not isinstance(d, Immediate):
                        result.add_vertex(d)
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
    
    
    def spill_sequential(self, graph: UndirectedAdjList) -> location:
        for vertex in graph.vertices():
            return vertex
    
    
    def spill_least_neighbours(self, graph: UndirectedAdjList) -> location:
        least_neighbours = self.spill_sequential(graph)
        for vertex in graph.vertices():
            if len(graph.adjacent(vertex)) < len(graph.adjacent(least_neighbours)):
                least_neighbours = vertex
        return least_neighbours
    
    
    def spill_most_neighbours(self, graph: UndirectedAdjList) -> location:
        most_neighbours = self.spill_sequential(graph)
        for vertex in graph.vertices():
            if len(graph.adjacent(vertex)) > len(graph.adjacent(most_neighbours)):
                most_neighbours = vertex
        return most_neighbours
    
    
    def spill_random(self, graph: UndirectedAdjList) -> location:
        index = random.randint(0, len(graph.vertices()) - 1)
        for i, vertex in enumerate(graph.vertices()):
            if i == index:
                return vertex
        return None
    
    def color_graph_step(self, vertex: location, neighbours: dict[location, list[location]], graph: UndirectedAdjList,
                         variables: set[Reg], stack: list[Reg], coloring: dict[Variable, Reg]) -> dict[Variable, Reg]:
        if vertex is None:
            return coloring
        
        stack.append(vertex)
        graph.remove_vertex(vertex)
        
        next_vertex = self.find_vertex(graph, len(variables))
        
        # check for spilling
        if self.use_spilling and next_vertex is None and len(graph.vertices()) > 0:
            self.spill_vertex = self.spill_method(graph)
            return None
        
        # recursive call
        result = self.color_graph_step(next_vertex, neighbours, graph, variables, stack, coloring)
        
        # check for spilling
        if result is None:
            return None
        
        # don't assign registers to registers
        if isinstance(vertex, Reg):
            return result
        
        # assign color to vertex
        for color in variables:
            # find available color
            is_color_available = True
            for neighbour in neighbours[vertex]:
                neighbour_color = result.get(neighbour)
                if neighbour_color is not None and neighbour_color == color:
                    is_color_available = False
                    break
            
            # if found, assign it
            if is_color_available:
                result[vertex] = color
                break
        
        return result

    def color_graph(self, graph: UndirectedAdjList, variables: set[location]) -> dict[Variable, Reg]:
        stack: list[Reg] = list()
        coloring: dict[Variable, Reg] = dict()
        neighbours: dict[location, list[location]] = dict()
        spill_list = []
        
        # find a coloring pattern until no spilling is needed
        result = None        
        while result is None:     
            # don't change original graph here..
            graph_cpy = copy.deepcopy(graph)
            
            # remove spilled vertices
            for vertex in spill_list:
                graph_cpy.remove_vertex(vertex)
               
            # find neighbours because removing vertices removes edges
            # so we don't lose track of neighbours
            for vertex in graph_cpy.vertices():
                neighbours[vertex] = graph_cpy.adjacent(vertex)
            
            # find coloring
            result = self.color_graph_step(self.find_vertex(graph_cpy, len(variables)), neighbours, graph_cpy, variables, stack, coloring)
            
            # check for spilling
            if result is None:
                # print("SPILLING: ", self.spill_vertex)
                spill_list.append(self.spill_vertex)
        
        return result


    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes(self, p: X86Program) -> X86Program:
        result: list[instr] = []
        live_after: dict[instr, set[location]] = self.uncover_live(p)
        interference: UndirectedAdjList = self.build_interference(p, live_after)
        coloring: dict[Variable, Reg] = self.color_graph(interference, self.registers)
        self.stack_size -= 8 * len(coloring)
        
        for inst in p.body:
            match inst:
                case Instr(inst, [s, d]):
                    result.append(Instr(inst, [coloring.get(s, s), coloring.get(d, d)]))
                case Instr(inst, [d]):
                    result.append(Instr(inst, [coloring.get(d, d)]))
                case other:
                    result.append(other)
                    
        return compiler.Compiler.assign_homes(self, X86Program(result))
                    

    ###########################################################################
    # Patch Instructions
    ###########################################################################
    
    def save(self, registers: list[Reg]) -> list[Instr]:
        self.stack_size = max(self.stack_size, self.stack_before + 8 * (len(registers) + 1))
        result: list[Instr] = []
        index = 1
        # save all variables onto the stack
        for reg in registers:
            # except for rax and rdi
            if reg.id != 'rax' and reg.id != 'rdi':
                result.append(Instr('movq', [reg, Deref('rbp', -(self.stack_before + 8 * index))]))
            index += 1
        return result
    
    def restore(self, registers: list[Reg]) -> list[Instr]:
        self.stack_size = max(self.stack_size, self.stack_before + 8 * (len(registers) + 1))
        result: list[Instr] = []
        index = 1
        # restore all variables from the stack
        for reg in registers:
            # except for rax and rdi
            if reg.id != 'rax' and reg.id != 'rdi':    
                result.append(Instr('movq', [Deref('rbp', -(self.stack_before + 8 * index)), reg]))
            index += 1
        return result
        
    def patch_instructions(self, p: X86Program) -> X86Program:
        p = compiler.Compiler.patch_instructions(self, p)
        result: list[instr] = []
        self.stack_before = self.stack_size
        
        live_after = self.uncover_live(p)
        
        for inst in p.body:
            match inst:
                case Callq(_, args) if self.save_restore_registers:
                    registers = live_after.get(inst, [])
                    # save caller saved registers onto the stack before the call
                    result.extend(self.save(registers))
                    # do the call
                    result.append(inst)
                    # restore afterwards
                    result.extend(self.restore(registers))
                case other:
                    result.append(other)                    
        
        return X86Program(result)

    ###########################################################################
    # Prelude & Conclusion
    ###########################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        return compiler.Compiler.prelude_and_conclusion(self, p)
                    
        
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
