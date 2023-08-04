	.align 16
block_229:
    movq $0, %rax
    jmp conclusion

	.align 16
block_231:
    movq %r9, %rdi
    movq %r10, -4016(%rbp)
    movq %rsi, -4024(%rbp)
    movq %r8, -4032(%rbp)
    movq %rcx, -4040(%rbp)
    movq %rdx, -4048(%rbp)
    movq %r9, -4056(%rbp)
    callq print_int
    movq -4016(%rbp), %r10
    movq -4024(%rbp), %rsi
    movq -4032(%rbp), %r8
    movq -4040(%rbp), %rcx
    movq -4048(%rbp), %rdx
    movq -4056(%rbp), %r9
    movq %r9, %rcx
    addq %rsi, %rcx
    movq %rsi, %r9
    movq %rcx, %rsi
    addq $1, %r8
    jmp loop_230

	.align 16
loop_230:
    cmpq %rdx, %r8
    jl block_231
    jmp block_229

	.align 16
start:
    movq %r10, -4016(%rbp)
    movq %rsi, -4024(%rbp)
    movq %r8, -4032(%rbp)
    movq %rcx, -4040(%rbp)
    movq %rdx, -4048(%rbp)
    movq %r9, -4056(%rbp)
    callq read_int
    movq -4016(%rbp), %r10
    movq -4024(%rbp), %rsi
    movq -4032(%rbp), %r8
    movq -4040(%rbp), %rcx
    movq -4048(%rbp), %rdx
    movq -4056(%rbp), %r9
    movq %rax, %rdx
    movq $0, %r9
    movq $1, %rsi
    movq $0, %r8
    jmp loop_230

	.align 16
conclusion:
    addq $4096, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4096, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


