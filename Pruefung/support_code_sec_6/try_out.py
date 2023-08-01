from ast import *
from utils import *
from compiler_tup import Compiler

compiler = Compiler()

prog="""
print(1 > 0)
"""

ast = parse(prog)
print('=====')
print(dump(ast, indent=2))

ast = compiler.shrink(ast)
print('=====')
print(ast)

ast = compiler.remove_complex_operands(ast)
print('=====')
print(ast)

ast = compiler.explicate_control(ast)
print('=====')
print(ast)

ast = compiler.select_instructions(ast)
print('=====')
print(ast)

ast = compiler.assign_homes(ast)
print('=====')
print(ast)

ast = compiler.patch_instructions(ast)
print('=====')
print(ast)
