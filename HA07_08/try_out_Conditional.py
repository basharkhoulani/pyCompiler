from ast import parse,dump
from compiler import Compiler as CompilerA
from compiler_register_allocator import Compiler as CompilerB
from compiler_conditionals import Compiler as CompilerC
from x86_ast import *

compiler = CompilerC()
prog="""
a = 0 if True else 1
i = input_int()
j = input_int()
if i == 0 and j != 1:
    print(1)
else:
    print(2)
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

current_program = parse(prog)
print(dump(current_program, indent=2))
for pass_name, pass_fn in compiler_passes.items():
    current_program = pass_fn(current_program)

    print()
    print('==================================================')
    print(f' Output of pass: {pass_name}')
    print('==================================================')
    print()
    print(current_program)
