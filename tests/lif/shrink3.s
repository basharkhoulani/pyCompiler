	.align 16
block_88:
    movq $0, %rax
    jmp conclusion

	.align 16
block_89:
    movq $0, %rdi
    movq %r9, -2040(%rbp)
    movq %rdx, -2048(%rbp)
    movq %rcx, -2056(%rbp)
    movq %r10, -2064(%rbp)
    movq %r8, -2072(%rbp)
    movq %rsi, -2080(%rbp)
    callq print_int
    movq -2040(%rbp), %r9
    movq -2048(%rbp), %rdx
    movq -2056(%rbp), %rcx
    movq -2064(%rbp), %r10
    movq -2072(%rbp), %r8
    movq -2080(%rbp), %rsi
    jmp block_88

	.align 16
block_90:
    movq $1, %rdi
    movq %r9, -2040(%rbp)
    movq %rdx, -2048(%rbp)
    movq %rcx, -2056(%rbp)
    movq %r10, -2064(%rbp)
    movq %r8, -2072(%rbp)
    movq %rsi, -2080(%rbp)
    callq print_int
    movq -2040(%rbp), %r9
    movq -2048(%rbp), %rdx
    movq -2056(%rbp), %rcx
    movq -2064(%rbp), %r10
    movq -2072(%rbp), %r8
    movq -2080(%rbp), %rsi
    jmp block_88

	.align 16
start:
    jmp block_90

	.align 16
conclusion:
    addq $2112, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2112, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


