from ast import parse,dump
from compiler import Compiler

compiler = Compiler()

prog="""
x = 10
y = 10 + x + x + 20
z = -y + x + -y
z = -z
z = z + input_int()
print(1 + z)
"""

ast = parse(prog)
print(dump(ast, indent=2))

print("===============================")

ast_after_rco = compiler.remove_complex_operands(ast)
print(str(ast_after_rco))

print("===============================")

ast_after_select_instrs = compiler.select_instructions(ast_after_rco)
print(ast_after_select_instrs)
