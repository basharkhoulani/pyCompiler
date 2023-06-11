from interp_x86.eval_x86 import X86Emulator

prog1="""
  .globl main
main:
  movq $10, %rax
  addq $32, %rax
  retq
"""

prog2="""
  .globl main
main:
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp
  movq $10, -8(%rbp)
  negq -8(%rbp)
  movq -8(%rbp), %rax
  addq $52, %rax
  addq $16, %rsp
  popq %rbp
  retq
"""

prog3="""
	.globl main
main:
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp
  movq $40, -8(%rbp)
  addq $2, -8(%rbp)
  movq -8(%rbp), %rdi
  callq print_int
  addq $16, %rsp
  popq %rbp
  retq
"""

for prog in prog1, prog2, prog3:
  emu = X86Emulator(logging=True)
  emu.parse_and_eval_program(prog)
