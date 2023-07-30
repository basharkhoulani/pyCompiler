from ast import *
from utils import *
from compiler_tup import Compiler

compiler = Compiler()

input_file = "test.py"

# prog = open(input_file).read()
prog = '''
t1 = ((7,),42)
t2 = (t1,)

if t1 is t2[0]:
   print(1)
else:
   print(0)

# prints 1
   
print(1 if t1[0][0] < 3 else t2[0][1])

# prints 42

# x = input_int() + 3
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

print('=====')
ast = compiler.explicate_control(ast)
print(ast)

print('=====')
ast = compiler.select_instructions(ast)
print(ast)

# print('=====')
# ast = compiler.assign_homes(ast)
# print(ast)

# print('=====')
# ast = compiler.patch_instructions(ast)
# print(ast)
