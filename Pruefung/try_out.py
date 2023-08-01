from ast import *
from utils import *
from compiler_tup import Compiler

compiler = Compiler()

input_file = "test.py"

# prog = open(input_file).read()
prog = '''
t = (1, 2, 3)
'''

print('PARSE =====')
ast = parse(prog)
print(dump(ast, indent=2))

print('SHRINK =====')
ast = compiler.shrink(ast)
print(ast)

print('EXPOSE =====')
ast = compiler.expose_allocation(ast)
print(ast)

print('RCO =====')
ast = compiler.remove_complex_operands(ast)
print(ast)

print('EXPLICATE =====')
ast = compiler.explicate_control(ast)
print(ast)

print('SELECT =====')
ast = compiler.select_instructions(ast)
print(ast)

print('HOMES =====')
ast = compiler.assign_homes(ast)
print(ast)

print('PATCH =====')
ast = compiler.patch_instructions(ast)
print(ast)

print('PREL CONCL =====')
ast = compiler.prelude_and_conclusion(ast)
print(ast)
