	.align 16
block_229:
    movq $0, %rax
    jmp conclusion

	.align 16
block_231:
    movq %r9, %rdi
    movq %r9, -4000(%rbp)
    movq %rdx, -4008(%rbp)
    movq %rcx, -4016(%rbp)
    movq %r10, -4024(%rbp)
    movq %r8, -4032(%rbp)
    movq %rsi, -4040(%rbp)
    callq print_int
    movq -4000(%rbp), %r9
    movq -4008(%rbp), %rdx
    movq -4016(%rbp), %rcx
    movq -4024(%rbp), %r10
    movq -4032(%rbp), %r8
    movq -4040(%rbp), %rsi
    movq %r9, %rcx
    addq %r8, %rcx
    movq %r8, %r9
    movq %rcx, %r8
    addq $1, %rdx
    jmp loop_230

	.align 16
loop_230:
    cmpq %rsi, %rdx
    jl block_231
    jmp block_229

	.align 16
start:
    movq %r9, -4000(%rbp)
    movq %rdx, -4008(%rbp)
    movq %rcx, -4016(%rbp)
    movq %r10, -4024(%rbp)
    movq %r8, -4032(%rbp)
    movq %rsi, -4040(%rbp)
    callq read_int
    movq -4000(%rbp), %r9
    movq -4008(%rbp), %rdx
    movq -4016(%rbp), %rcx
    movq -4024(%rbp), %r10
    movq -4032(%rbp), %r8
    movq -4040(%rbp), %rsi
    movq %rax, %rsi
    movq $0, %r9
    movq $1, %r8
    movq $0, %rdx
    jmp loop_230

	.align 16
conclusion:
    addq $4080, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4080, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


