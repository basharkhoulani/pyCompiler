	.align 16
block_143:
    movq $0, %rax
    jmp conclusion

	.align 16
block_144:
    movq $1, %rdi
    movq %rsi, -2488(%rbp)
    movq %rdx, -2496(%rbp)
    movq %r10, -2504(%rbp)
    movq %r9, -2512(%rbp)
    movq %r8, -2520(%rbp)
    movq %rcx, -2528(%rbp)
    callq print_int
    movq -2488(%rbp), %rsi
    movq -2496(%rbp), %rdx
    movq -2504(%rbp), %r10
    movq -2512(%rbp), %r9
    movq -2520(%rbp), %r8
    movq -2528(%rbp), %rcx
    jmp block_143

	.align 16
block_145:
    movq $0, %rdi
    movq %rsi, -2488(%rbp)
    movq %rdx, -2496(%rbp)
    movq %r10, -2504(%rbp)
    movq %r9, -2512(%rbp)
    movq %r8, -2520(%rbp)
    movq %rcx, -2528(%rbp)
    callq print_int
    movq -2488(%rbp), %rsi
    movq -2496(%rbp), %rdx
    movq -2504(%rbp), %r10
    movq -2512(%rbp), %r9
    movq -2520(%rbp), %r8
    movq -2528(%rbp), %rcx
    jmp block_143

	.align 16
start:
    jmp block_144

	.align 16
conclusion:
    addq $2560, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2560, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


