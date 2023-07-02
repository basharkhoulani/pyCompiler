from ast import parse,dump
from compiler import Compiler as CompilerA
from compiler_register_allocator import Compiler as CompilerB
from compiler_conditionals import Compiler as CompilerC
from x86_ast import *

compiler = CompilerC()
progA="""
i = 0
print(1)
while i < 100:
    i = i + 1
    print(i)
print(2)
"""
progB="""
i = input_int()
j = input_int()
if i == 0 and j != 1:
    if input_int() == 2:
        print(2+4)
    else:
        print(1+8)
else:
    print(2+24)
print(0)
"""

compiler_passes = {
    'shrink': compiler.shrink,
    'remove complex operands': compiler.remove_complex_operands,
    'explicate control': compiler.explicate_control,
    'select instructions': compiler.select_instructions,
    'assign homes': compiler.assign_homes,
    'patch instructions': compiler.patch_instructions,
    'prelude & conclusion': compiler.prelude_and_conclusion,
}

prog = progA
current_program = parse(prog)

print()
print('==================================================')
print(f' RAW CODE')
print('==================================================')
print()
print(prog)

print()
print('==================================================')
print(f' Output of pass: AST')
print('==================================================')
print()
print(dump(current_program, indent=2))

print()
print('==================================================')
print(f' Output of pass: RCO AST')
print('==================================================')
print()
print(dump(compiler.remove_complex_operands(compiler.shrink(current_program)), indent=2))


for pass_name, pass_fn in compiler_passes.items():
    current_program = pass_fn(current_program)

    print()
    print('==================================================')
    print(f' Output of pass: {pass_name}')
    print('==================================================')
    print()
    print(current_program)
