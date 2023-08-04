	.align 16
block_30:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $130, 0(%r11)
    movq %r11, %rsi
    movq %rsi, %r11
    movq %rdx, 8(%r11)
    movq %rsi, %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %r11
    movq 16(%r11), %rcx
    movq %rcx, %rdi
    movq %r9, -168(%rbp)
    movq %rdx, -176(%rbp)
    movq %r10, -184(%rbp)
    movq %r8, -192(%rbp)
    movq %rcx, -200(%rbp)
    movq %rsi, -208(%rbp)
    callq print_int
    movq -168(%rbp), %r9
    movq -176(%rbp), %rdx
    movq -184(%rbp), %r10
    movq -192(%rbp), %r8
    movq -200(%rbp), %rcx
    movq -208(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_31:
    movq %r15, %rdi
    movq $16, %rsi
    movq %rsi, 0(%r15)
    movq %rdx, -8(%r15)
    movq %r8, -16(%r15)
    movq %rsi, -24(%r15)
    movq %rcx, -32(%r15)
    movq %rcx, -40(%r15)
    movq %rcx, -48(%r15)
    movq %rsi, -56(%r15)
    movq %r9, -168(%rbp)
    movq %rdx, -176(%rbp)
    movq %r10, -184(%rbp)
    movq %r8, -192(%rbp)
    movq %rcx, -200(%rbp)
    movq %rsi, -208(%rbp)
    callq collect
    movq -168(%rbp), %r9
    movq -176(%rbp), %rdx
    movq -184(%rbp), %r10
    movq -192(%rbp), %r8
    movq -200(%rbp), %rcx
    movq -208(%rbp), %rsi
    jmp block_30

	.align 16
block_32:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $132, 0(%r11)
    movq %r11, %r8
    movq %r8, %r11
    movq %rsi, 8(%r11)
    movq %r8, %r11
    movq %rdx, 16(%r11)
    movq %r8, %rcx
    movq %rcx, %rdx
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_30
    jmp block_31

	.align 16
block_33:
    movq %r15, %rdi
    movq $24, %rsi
    movq %rsi, 0(%r15)
    movq %rdx, -8(%r15)
    movq %r8, -16(%r15)
    movq %rsi, -24(%r15)
    movq %rcx, -32(%r15)
    movq %rcx, -40(%r15)
    movq %rcx, -48(%r15)
    movq %rsi, -56(%r15)
    movq %r9, -168(%rbp)
    movq %rdx, -176(%rbp)
    movq %r10, -184(%rbp)
    movq %r8, -192(%rbp)
    movq %rcx, -200(%rbp)
    movq %rsi, -208(%rbp)
    callq collect
    movq -168(%rbp), %r9
    movq -176(%rbp), %rdx
    movq -184(%rbp), %r10
    movq -192(%rbp), %r8
    movq -200(%rbp), %rcx
    movq -208(%rbp), %rsi
    jmp block_32

	.align 16
block_34:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $2, 0(%r11)
    movq %r11, %rsi
    movq %rsi, %r11
    movq %rdx, 8(%r11)
    movq $42, %rdx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_32
    jmp block_33

	.align 16
block_35:
    movq %r15, %rdi
    movq $16, %rsi
    movq %rsi, 0(%r15)
    movq %rdx, -8(%r15)
    movq %r8, -16(%r15)
    movq %rsi, -24(%r15)
    movq %rcx, -32(%r15)
    movq %rcx, -40(%r15)
    movq %rcx, -48(%r15)
    movq %rsi, -56(%r15)
    movq %r9, -168(%rbp)
    movq %rdx, -176(%rbp)
    movq %r10, -184(%rbp)
    movq %r8, -192(%rbp)
    movq %rcx, -200(%rbp)
    movq %rsi, -208(%rbp)
    callq collect
    movq -168(%rbp), %r9
    movq -176(%rbp), %rdx
    movq -184(%rbp), %r10
    movq -192(%rbp), %r8
    movq -200(%rbp), %rcx
    movq -208(%rbp), %rsi
    jmp block_34

	.align 16
start:
    movq $7, %rdx
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_34
    jmp block_35

	.align 16
conclusion:
    addq $240, %rsp
    subq $64, %r15
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $240, %rsp
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
    movq $0, 48(%r15)
    movq $0, 56(%r15)
    addq $64, %r15
    jmp start


