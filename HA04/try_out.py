from ast import parse,dump
from compiler import Compiler

compiler = Compiler()

prog="""
v = 50

a = v+v+v+v+v
b = v-v-v-v-v
c = v+v+v-v-v-v
d = v-v-v+v+v+v
e = v+v-v+v-v+v
f = v-v+v-v+v-v
g = v+v-v-v+v-v
h = v-v+v+v-v+v
i = v+v+v+v-v-v
j = v-v-v-v+v+v
k = v+v-v-v-v+v
l = v-v+v+v+v-v
print(a - b + c - d + e - f + g - h + i - j + k - l)
"""

ast = parse(prog)
print(dump(ast, indent=2))

print("===============================")

ast_after_rco = compiler.remove_complex_operands(ast)
print(str(ast_after_rco))

print("===============================")

ast_after_select_instrs = compiler.select_instructions(ast_after_rco)
print(ast_after_select_instrs)

print("===============================")

ast_after_assign_registers = compiler.assign_homes(ast_after_select_instrs)
print(ast_after_assign_registers)

print("===============================")

ast_after_patch_instructions = compiler.patch_instructions(ast_after_assign_registers)
print(ast_after_patch_instructions)
