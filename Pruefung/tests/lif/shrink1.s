	.align 16
block_143:
    movq $0, %rax
    jmp conclusion

	.align 16
block_144:
    movq $1, %rdi
    movq %r10, -2496(%rbp)
    movq %rsi, -2504(%rbp)
    movq %r8, -2512(%rbp)
    movq %rcx, -2520(%rbp)
    movq %rdx, -2528(%rbp)
    movq %r9, -2536(%rbp)
    callq print_int
    movq -2496(%rbp), %r10
    movq -2504(%rbp), %rsi
    movq -2512(%rbp), %r8
    movq -2520(%rbp), %rcx
    movq -2528(%rbp), %rdx
    movq -2536(%rbp), %r9
    jmp block_143

	.align 16
block_145:
    movq $0, %rdi
    movq %r10, -2496(%rbp)
    movq %rsi, -2504(%rbp)
    movq %r8, -2512(%rbp)
    movq %rcx, -2520(%rbp)
    movq %rdx, -2528(%rbp)
    movq %r9, -2536(%rbp)
    callq print_int
    movq -2496(%rbp), %r10
    movq -2504(%rbp), %rsi
    movq -2512(%rbp), %r8
    movq -2520(%rbp), %rcx
    movq -2528(%rbp), %rdx
    movq -2536(%rbp), %r9
    jmp block_143

	.align 16
start:
    jmp block_144

	.align 16
conclusion:
    addq $2576, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2576, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


