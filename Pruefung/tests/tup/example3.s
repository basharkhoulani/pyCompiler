	.align 16
block_8:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $130, 0(%r11)
    movq %r11, %rdx
    movq %rdx, %r11
    movq %rsi, 8(%r11)
    movq %rdx, %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %rdi
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r10, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %rcx, -40(%rbp)
    movq %rsi, -48(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r10
    movq -32(%rbp), %r8
    movq -40(%rbp), %rcx
    movq -48(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_9:
    movq %r15, %rdi
    movq $16, %rsi
    movq %rdx, 0(%r15)
    movq %rcx, -8(%r15)
    movq %rcx, -16(%r15)
    movq %rsi, -24(%r15)
    movq %rsi, -32(%r15)
    movq %rcx, -40(%r15)
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r10, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %rcx, -40(%rbp)
    movq %rsi, -48(%rbp)
    callq collect
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r10
    movq -32(%rbp), %r8
    movq -40(%rbp), %rcx
    movq -48(%rbp), %rsi
    jmp block_8

	.align 16
block_10:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $2, 0(%r11)
    movq %r11, %rsi
    movq %rsi, %r11
    movq %rdx, 8(%r11)
    movq %rsi, %rcx
    movq %rcx, %rsi
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_8
    jmp block_9

	.align 16
block_11:
    movq %r15, %rdi
    movq $16, %rsi
    movq %rdx, 0(%r15)
    movq %rcx, -8(%r15)
    movq %rcx, -16(%r15)
    movq %rsi, -24(%r15)
    movq %rsi, -32(%r15)
    movq %rcx, -40(%r15)
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r10, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %rcx, -40(%rbp)
    movq %rsi, -48(%rbp)
    callq collect
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r10
    movq -32(%rbp), %r8
    movq -40(%rbp), %rcx
    movq -48(%rbp), %rsi
    jmp block_10

	.align 16
start:
    movq $42, %rdx
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_10
    jmp block_11

	.align 16
conclusion:
    addq $80, %rsp
    subq $48, %r15
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    movq $0, 16(%r15)
    movq $0, 24(%r15)
    movq $0, 32(%r15)
    movq $0, 40(%r15)
    addq $48, %r15
    jmp start


