from ast import parse,dump
from compiler import Compiler as CompilerA
from compiler_register_allocator import Compiler as CompilerB
from graphviz import Graph
from x86_ast import *

compiler_a = CompilerA()
# compiler_b = CompilerB()

prog="""
print(input_int() + input_int() + input_int())
"""

ast = parse(prog)
print(dump(ast, indent=2))

print("=== REMOVE_COMPLEX_OPERANDS ===")

ast_after_rco = compiler_a.remove_complex_operands(ast)
print(str(ast_after_rco))

print("=== SELECT_INSTRUCTIONS ===")

ast_after_select_instrs = compiler_a.select_instructions(ast_after_rco)
print(ast_after_select_instrs)

print("=== ASSIGN_REGISTERS ===")

ast_after_assign_registers = compiler_a.assign_homes(ast_after_select_instrs)
print(ast_after_assign_registers)

print("=== PATCH_INSTRUCTIONS ===")

ast_after_patch_instructions = compiler_a.patch_instructions(ast_after_assign_registers)
print(ast_after_patch_instructions)

print("=== PRELUDE_AND_EPILOGUE ===")

ast_after_prelude_and_epilogue = compiler_a.prelude_and_conclusion(ast_after_patch_instructions)
print(ast_after_prelude_and_epilogue)