from ast import parse,dump
from compiler_tup import Compiler as CompilerC
from x86_ast import *
from interp_x86.eval_x86 import X86Emulator

compiler = CompilerC()
progA="""
t = (42, )
print(t[0])

"""
progB="""
t1 = 3, 7
t2 = t1
t3 = 3, 7
print(42 if (t1 is t2) and not (t1 is t3) else 0)
"""

compiler_passes = {
    'shrink': compiler.shrink,
    'expose allocation': compiler.expose_allocation,
    'remove complex operands': compiler.remove_complex_operands,
    'explicate control': compiler.explicate_control,
    'select instructions': compiler.select_instructions,
    'assign homes': compiler.assign_homes,
    'patch instructions': compiler.patch_instructions,
    'prelude & conclusion': compiler.prelude_and_conclusion,
}

prog = progB
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
