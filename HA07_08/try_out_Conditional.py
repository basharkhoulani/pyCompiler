from ast import parse,dump
from compiler import Compiler as CompilerA
from compiler_register_allocator import Compiler as CompilerB
from compiler_conditionals import Compiler as CompilerC
from x86_ast import *
from interp_x86.eval_x86 import X86Emulator

compiler = CompilerC()
progA="""
a = 2
b = 8
c = a < b
print(4)
if c:
    print(1)
else:
    d = a == b
    while d:
        print(8)
        d = False
"""
progB="""
i = 0
print(4)
t = 2
print(1)
while (i < 100) if t == 2 else (i < 50):
    i = i + 1
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
for pass_name, pass_fn in compiler_passes.items():
    current_program = pass_fn(current_program)

    print()
    print('==================================================')
    print(f' Output of pass: {pass_name}')
    print('==================================================')
    print()
    print(current_program)

if 0:
    emu = X86Emulator(logging=True)
    emu.parse_and_eval_program(str(current_program))
