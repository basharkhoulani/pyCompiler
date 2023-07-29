from ast import *
from utils import *
from compiler_tup import Compiler

compiler = Compiler()

input_file = "test.py"

# prog = open(input_file).read()
prog = '''
t1 = (1, 2 + 3 + input_int())
t2 = (t1, 2)
print(t2[0][1] + 1)
'''

print('=====')
ast = parse(prog)
print(dump(ast, indent=2))

print('=====')
ast = compiler.shrink(ast)
print(ast)

print('=====')
ast = compiler.expose_allocation(ast)
print(ast)

print('=====')
ast = compiler.remove_complex_operands(ast)
print(ast)

# ast = compiler.explicate_control(ast)
# print('=====')
# print(ast)

# ast = compiler.select_instructions(ast)
# print('=====')
# print(ast)

# ast = compiler.assign_homes(ast)
# print('=====')
# print(ast)

# ast = compiler.patch_instructions(ast)
# print('=====')
# print(ast)
