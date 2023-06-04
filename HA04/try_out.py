from ast import parse,dump
from compiler import Compiler

compiler = Compiler()

prog="""
1+1+input_int()
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

ast_after_select_homes = compiler.assign_homes(ast_after_select_instrs)
print(ast_after_select_homes)

print("===============================")

ast_after_patch_instructions = compiler.patch_instructions(ast_after_select_homes)
print(ast_after_patch_instructions)