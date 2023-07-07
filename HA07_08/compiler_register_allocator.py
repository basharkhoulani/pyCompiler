import compiler
import dataflow_analysis
from graph import UndirectedAdjList, DirectedAdjList
from ast import *
from x86_ast import *
import copy

vertexLabelLambda = lambda v: v.id if isinstance(v, Reg) else str(v)

caller_saved_registers: set[location] = set(
    [
        Reg('rax'),
        Reg('rcx'),
        Reg('rdx'),
        Reg('rsi'),
        Reg('rdi'),
        Reg('r8'),
        Reg('r9'),
        Reg('r10'),
        Reg('r11'),
    ]
)

callee_saved_registers: set[location] = set(
    [Reg('rsp'), Reg('rbp'), Reg('rbx'), Reg('r12'), Reg('r13'), Reg('r14'), Reg('r15')]
)

registers_for_coloring = [
    Reg('rcx'),
    Reg('rdx'),
    Reg('rsi'),
    Reg('r8'),
    Reg('r9'),
    Reg('r10'),
    Reg('r11'),
]


def get_loc_from_arg(a: arg) -> set[location]:
    match a:
        case Reg(_):
            return set([a])
        case Variable(_):
            return set([a])
        case _:
            return set([])


class Compiler(compiler.Compiler):

    ###########################################################################
    # Uncover Live
    ###########################################################################

    def read_vars(self, i: instr) -> set[location]:
        match i:
            case Instr('movq', [s, d]):
                return get_loc_from_arg(s)
            case Instr('addq', [s, d]) | Instr('subq', [s, d]):
                return get_loc_from_arg(s) | get_loc_from_arg(d)
            case Instr('negq', [d]):
                return get_loc_from_arg(d)
            case Instr('pushq', [d]):
                return get_loc_from_arg(d)
            case Instr('cmpq', [s, d]):
                return get_loc_from_arg(s) | get_loc_from_arg(d)
            case Callq(_, n):
                return set([Reg('rdi')]) if n == 1 else set()
            case _:
                return set()

    def write_vars(self, i: instr) -> set[location]:
        match i:
            case Instr('movq', [s, d]):
                return get_loc_from_arg(d)
            case Instr('addq', [s, d]) | Instr('subq', [s, d]):
                return get_loc_from_arg(d)
            case Instr('negq', [d]):
                return get_loc_from_arg(d)
            case Instr('pushq', [d]):
                return get_loc_from_arg(d)
            case Callq(_, n):
                return set([Reg('rax')])
            case Instr('movzbq', [a, b]):
                return get_loc_from_arg(b)
            case _:
                return set()


    def build_adj_graph(self, p : X86Program) -> DirectedAdjList:
        edges = []

        for blockID, instrs in p.body.items():
            for instr in instrs:
                match instr:
                    case Jump(label):
                        edges.append((label, blockID))
                    case JumpIf(cc, label):
                        edges.append((label, blockID))

        return DirectedAdjList(edges)

    def assign_transfer(self, node, input : set):

        #postlude case
        if node=="end_main":
            return set([Reg("rax"), Reg("rbp")])


        l_after = input
        for instr in reversed(self.p.body[node]):
            l_before = (l_after - self.write_vars(instr)) | self.read_vars(instr)
            l_after = l_before

        self.mapping[node] = l_after
        return l_after


    def uncover_live_simple(self, instrs : list, l_after : set):
        result = {}
        l_before = set()

        for i in reversed(instrs):
            result[i] = l_after

            l_before = (l_after - self.write_vars(i)) | self.read_vars(i)
            l_after = l_before

        return result

    def uncover_live(self, p: X86Program) -> dict[instr, set[location]]:
        result = {}

        #to make old tests not break
        if isinstance(p.body, list):
            return self.uncover_live_simple(p.body, set())

        #analyze dataflow for live
        self.p = p
        self.mapping = {}
        dataflow_analysis.analyze_dataflow(
            self.build_adj_graph(p),
            lambda node, input: self.assign_transfer(node, input),
            set(),
    	    lambda a, b: a.union(b)
        )

        #analyze every block a final time
        result = {}
        for label, instrs in p.body.items():
            result = result | self.uncover_live_simple(instrs, self.mapping[label])

        return result

    ############################################################################
    # Build Interference
    ############################################################################
    def build_interference_simple(
        self, instrs: list, live_after: dict[instr, set[location]], graph : UndirectedAdjList
    ) -> UndirectedAdjList:

        for instr in instrs:
            l_after = live_after[instr]

            match instr:
                case Instr('movq', [s, d]):
                    for v in l_after:
                        if v != s and v != d and not graph.has_edge(v, d):
                            graph.add_edge(v, d)
                case _:
                    for v in l_after:
                        for d in self.write_vars(instr):
                            if v != d and not graph.has_edge(v, d):
                                graph.add_edge(v, d)
        return graph

    def build_interference(
        self, p: X86Program, live_after: dict[instr, set[location]]
    ) -> UndirectedAdjList:
        graph = UndirectedAdjList(vertex_label=vertexLabelLambda)

        for (_, vs) in live_after.items():
            for v in vs:
                graph.add_vertex(v)

        #mantain old code functions
        if isinstance(p.body, list):
            return self.build_interference_simple(p.body, live_after, graph)

        #process block for block the graph
        for label, instrs in p.body.items():
            self.build_interference_simple(instrs, live_after, graph)

        return graph

    ############################################################################
    # Allocate Registers
    ############################################################################

    # select spill candidate by most neighbors
    def find_spill(self, graph: UndirectedAdjList) -> location:
        most_neighbors = list(graph.vertices())[0]
        for v in graph.vertices():
            if len(graph.adjacent(v)) > len(graph.adjacent(most_neighbors)):
                most_neighbors = v

        return v

    def color_graph(
        self, graph: UndirectedAdjList, colors: set[location]
    ) -> dict[Variable, arg]:
        coloring = {}

        orig_graph = copy.deepcopy(graph)

        k = len(colors)
        stack = []

        # for all vertices in the graph, select a vertex and remove it and put it on stack
        while len(graph.vertices()) > 0:
            # get vertex v with neighbors(v) < k
            v = next(
                filter(lambda v: len(graph.adjacent(v)) < k, graph.vertices()), None
            )

            # could not find vertex with neighbors(v) < k
            if v is None:
                potential_spill = self.find_spill(graph)
                graph.remove_vertex(potential_spill)
                stack.append(potential_spill)
            # found vertex
            else:
                graph.remove_vertex(v)
                stack.append(v)

        # for all vertices on stack, assign a color to them if possible
        while len(stack) > 0:
            d = stack.pop()

            if isinstance(d, Reg):
                continue

            neighbors = orig_graph.adjacent(d)

            # find available color not assigned to neighbors(d)
            color = next(
                filter(
                    lambda c: not c in [coloring.get(u, None) for u in neighbors],
                    colors,
                ),
                None,
            )

            # if colorable, assign the color
            if color != None:
                coloring[d] = color

        return coloring

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes(self, p: X86Program) -> X86Program:
        live_after = self.uncover_live(p)
        rig = self.build_interference(p, live_after)
        home = self.color_graph(rig, registers_for_coloring)

        #mantain old code compatibily
        if isinstance(p.body, list):
            return X86Program(super().assign_homes_instrs(p.body, home))
        
        blocks = {}
        for label, instrs in p.body.items():
            blocks[label] = self.assign_homes_instrs(instrs, home)

        #set live after for patch callq instructions
        out = X86Program(blocks)
        #self.live_after = self.uncover_live(out)
        return out

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
            if isinstance(reg, Reg) and reg in caller_saved_registers and reg in registers_for_coloring:
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
            if isinstance(reg, Reg) and reg in caller_saved_registers and reg in registers_for_coloring:
                result.append(Instr('movq', [Deref('rbp', -(self.stack_before + 8 * index)), reg]))
                index += 1
        return result
        
    def patch_instr(self, i: instr) -> list[instr]:
        match i:
            case Callq(_, args):
                result: list[instr] = []
                #registers = self.live_after.get(i, [])
                # save caller saved registers onto the stack before the call
                result.extend(self.save(caller_saved_registers))
                # do the call
                result.append(i)
                # restore caller saved registers after the call
                result.extend(self.restore(caller_saved_registers))
                return result
            case _:
                return super().patch_instr(i)


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
