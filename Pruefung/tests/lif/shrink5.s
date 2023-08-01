	.align 16
block_149:
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %rsi, -2568(%rbp)
    movq %rdx, -2576(%rbp)
    movq %r10, -2584(%rbp)
    movq %r9, -2592(%rbp)
    movq %r8, -2600(%rbp)
    movq %rcx, -2608(%rbp)
    callq print_int
    movq -2568(%rbp), %rsi
    movq -2576(%rbp), %rdx
    movq -2584(%rbp), %r10
    movq -2592(%rbp), %r9
    movq -2600(%rbp), %r8
    movq -2608(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
block_150:
    movq $0, %rdx
    jmp block_149

	.align 16
block_151:
    movq $2, %rdx
    jmp block_149

	.align 16
start:
    movq $4, %rcx
    jmp block_151

	.align 16
conclusion:
    addq $2640, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2640, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


