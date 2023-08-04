	.align 16
block_156:
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %r10, -2720(%rbp)
    movq %r8, -2728(%rbp)
    movq %rsi, -2736(%rbp)
    movq %rcx, -2744(%rbp)
    movq %r9, -2752(%rbp)
    movq %rdx, -2760(%rbp)
    callq print_int
    movq -2720(%rbp), %r10
    movq -2728(%rbp), %r8
    movq -2736(%rbp), %rsi
    movq -2744(%rbp), %rcx
    movq -2752(%rbp), %r9
    movq -2760(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_157:
    movq $0, %rdx
    jmp block_156

	.align 16
block_158:
    movq $2, %rdx
    jmp block_156

	.align 16
start:
    movq $4, %rcx
    jmp block_158

	.align 16
conclusion:
    addq $2800, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2800, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


