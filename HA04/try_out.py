from ast import parse,dump
from compiler import Compiler

compiler = Compiler()

prog="""
v = 4 + 8 + -8 * 12
print(40 + 2 + v)
"""

ast = parse(prog)
print(dump(ast, indent=2))

print("===============================")

ast_after_rco = compiler.remove_complex_operands(ast)

print(str(ast_after_rco))

print("===============================")

ast_after_select_instrs = compiler.select_instructions(ast_after_rco)
print(ast_after_select_instrs)
