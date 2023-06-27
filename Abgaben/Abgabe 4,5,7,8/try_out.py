from ast import parse,dump
from compiler_register_allocator import Compiler

compiler = Compiler()

progA="""
a = input_int() + 2
b = input_int() + 4
c = input_int() + 8
d = input_int() + 16
e = input_int() + 32
print(a + b + c + d + e)
"""

progB="""
a = 1
b = 2
c = 3
c = a + b + c
print_int(c + 4)
"""

ast = parse(progA)
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

print("===============================")

ast_after_patch_instructions = compiler.prelude_and_conclusion(ast_after_assign_registers)
print(ast_after_patch_instructions)
