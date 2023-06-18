from ast import parse,dump
from compiler import Compiler as CompilerA
from compiler_register_allocator import Compiler as CompilerB
from graphviz import Graph
from x86_ast import *
from time import time

# compiler_a = CompilerA()
compiler_b = CompilerB()

prog="""
a = 1
b = 1
c = 1
d = 1
e = 1
f = 1
g = 1
h = 1
i = 1
j = 1
k = 1
l = 1
m = 1
n = 1
o = 1
p = 1
q = 1
r = 1
print(a + b + c)
print(a + b + c + d + e + f + g + h + i + j + k + l + m + n + o + p + q + r)
"""

ast = parse(prog)
print(dump(ast, indent=2))

print("=== REMOVE_COMPLEX_OPERANDS ===")

ast_after_rco = compiler_b.remove_complex_operands(ast)
print(str(ast_after_rco))

print("=== SELECT_INSTRUCTIONS ===")

ast_after_select_instrs = compiler_b.select_instructions(ast_after_rco)
print(ast_after_select_instrs)

print("=== UNCOVER_LIVE ===")

uncover_life_dict = compiler_b.uncover_live(ast_after_select_instrs)
for k,v in uncover_life_dict.items():
    s = str(k).replace("\n", "")
    s = s.ljust(25)
    print(f"{s} :  {v}")

print("\n\n=== BUILD_INTERFERENCE ===")

interference_graph = compiler_b.build_interference(ast_after_select_instrs, uncover_life_dict)
graph: Graph = interference_graph.show()
graph.render("graph", format="png", view=True)

print("\n\n=== COLOR_GRAPH ===")
begin = time()
colored_graph = compiler_b.color_graph(interference_graph, {Reg('rax'), Reg('rcx'), Reg('rdx'), Reg('rsi'), Reg('rdi'), Reg('r8'), Reg('r9'), Reg('r10'), Reg('r11')})
for k,v in colored_graph.items():
    s = str(k).replace("\n", "")
    s = s.ljust(25)
    v = str(v).replace("\n", "")
    print(f"{s} :  {v}")
end = time()
print(f"Item count: {len(colored_graph)}")
print(f"Time in ms: {(end-begin) * 1000}")

# print("\n\n=== ASSIGN_REGISTERS ===")

ast_after_assign_registers = compiler_b.assign_homes(ast_after_select_instrs)
# print(ast_after_assign_registers)

# print("=== PATCH_INSTRUCTIONS ===")

ast_after_patch_instructions = compiler_b.patch_instructions(ast_after_assign_registers)
# print(ast_after_patch_instructions)

print("=== PRELUDE_AND_EPILOGUE ===")

ast_after_prelude_and_epilogue = compiler_b.prelude_and_conclusion(ast_after_patch_instructions)
print(ast_after_prelude_and_epilogue)

