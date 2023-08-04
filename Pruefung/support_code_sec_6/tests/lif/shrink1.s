	.align 16
block_113:
    movq $0, %rax
    jmp conclusion

	.align 16
block_114:
    movq $1, %rdi
    movq %r10, -2240(%rbp)
    movq %r8, -2248(%rbp)
    movq %rsi, -2256(%rbp)
    movq %rcx, -2264(%rbp)
    movq %r9, -2272(%rbp)
    movq %rdx, -2280(%rbp)
    callq print_int
    movq -2240(%rbp), %r10
    movq -2248(%rbp), %r8
    movq -2256(%rbp), %rsi
    movq -2264(%rbp), %rcx
    movq -2272(%rbp), %r9
    movq -2280(%rbp), %rdx
    jmp block_113

	.align 16
block_115:
    movq $0, %rdi
    movq %r10, -2240(%rbp)
    movq %r8, -2248(%rbp)
    movq %rsi, -2256(%rbp)
    movq %rcx, -2264(%rbp)
    movq %r9, -2272(%rbp)
    movq %rdx, -2280(%rbp)
    callq print_int
    movq -2240(%rbp), %r10
    movq -2248(%rbp), %r8
    movq -2256(%rbp), %rsi
    movq -2264(%rbp), %rcx
    movq -2272(%rbp), %r9
    movq -2280(%rbp), %rdx
    jmp block_113

	.align 16
start:
    jmp block_114

	.align 16
conclusion:
    addq $2320, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2320, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


