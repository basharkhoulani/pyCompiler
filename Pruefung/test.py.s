	.align 16
block_20:
    movq %rcx, %rdi
    movq %rsi, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %r10, -40(%rbp)
    movq %r9, -48(%rbp)
    callq print_int
    movq -8(%rbp), %rsi
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r8
    movq -40(%rbp), %r10
    movq -48(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
block_21:
    movq $1, %rcx
    jmp block_20

	.align 16
block_22:
    movq $0, %rcx
    jmp block_20

	.align 16
block_23:
    movq %rcx, %rdi
    movq %rsi, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %r10, -40(%rbp)
    movq %r9, -48(%rbp)
    callq print_int
    movq -8(%rbp), %rsi
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r8
    movq -40(%rbp), %r10
    movq -48(%rbp), %r9
    movq %rdx, %r11
    movq 16(%r11), %rcx
    movq %rcx, %r11
    movq 16(%r11), %rcx
    cmpq $4, %rcx
    je block_21
    jmp block_22

	.align 16
block_24:
    movq $1, %rcx
    jmp block_23

	.align 16
block_25:
    movq $0, %rcx
    jmp block_23

	.align 16
block_26:
    movq %rcx, %rdi
    movq %rsi, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %r10, -40(%rbp)
    movq %r9, -48(%rbp)
    callq print_int
    movq -8(%rbp), %rsi
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r8
    movq -40(%rbp), %r10
    movq -48(%rbp), %r9
    movq %rdx, %r11
    movq 16(%r11), %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    cmpq $3, %rcx
    je block_24
    jmp block_25

	.align 16
block_27:
    movq $1, %rcx
    jmp block_26

	.align 16
block_28:
    movq $0, %rcx
    jmp block_26

	.align 16
block_29:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $260, 0(%r11)
    movq %r11, %rdx
    movq %rdx, %r11
    movq %rsi, 8(%r11)
    movq %rdx, %r11
    movq %rcx, 16(%r11)
    movq %rdx, %r11
    movq 8(%r11), %rcx
    cmpq $2, %rcx
    je block_27
    jmp block_28

	.align 16
block_30:
    movq %r15, %rdi
    movq $24, %rsi
    movq %rcx, 0(%r15)
    movq %r8, -8(%r15)
    movq %rcx, -16(%r15)
    movq %rdx, -24(%r15)
    movq %rcx, -32(%r15)
    movq %rdx, -40(%r15)
    movq %rdx, -48(%r15)
    movq %rcx, -56(%r15)
    movq %rsi, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %r10, -40(%rbp)
    movq %r9, -48(%rbp)
    callq collect
    movq -8(%rbp), %rsi
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r8
    movq -40(%rbp), %r10
    movq -48(%rbp), %r9
    jmp block_29

	.align 16
block_31:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4, 0(%r11)
    movq %r11, %r8
    movq %r8, %r11
    movq %rcx, 8(%r11)
    movq %r8, %r11
    movq %rdx, 16(%r11)
    movq %r8, %rcx
    movq free_ptr(%rip), %rdx
    addq $24, %rdx
    cmpq fromspace_end(%rip), %rdx
    jl block_29
    jmp block_30

	.align 16
block_32:
    movq %r15, %rdi
    movq $24, %rsi
    movq %rcx, 0(%r15)
    movq %r8, -8(%r15)
    movq %rcx, -16(%r15)
    movq %rdx, -24(%r15)
    movq %rcx, -32(%r15)
    movq %rdx, -40(%r15)
    movq %rdx, -48(%r15)
    movq %rcx, -56(%r15)
    movq %rsi, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %r10, -40(%rbp)
    movq %r9, -48(%rbp)
    callq collect
    movq -8(%rbp), %rsi
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r8
    movq -40(%rbp), %r10
    movq -48(%rbp), %r9
    jmp block_31

	.align 16
block_33:
    movq $3, %rcx
    movq $4, %rdx
    movq free_ptr(%rip), %r8
    addq $24, %r8
    cmpq fromspace_end(%rip), %r8
    jl block_31
    jmp block_32

	.align 16
block_34:
    movq $2, %rsi
    jmp block_33

	.align 16
block_35:
    movq $1, %rsi
    jmp block_33

	.align 16
block_36:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $2, 0(%r11)
    movq %r11, %rdx
    movq %rdx, %r11
    movq %rcx, 8(%r11)
    movq %rdx, %rcx
    movq %rcx, %r11
    movq 0(%r11), %r11
    andq $126, %r11
    sarq $1, %r11
    movq %r11, %rcx
    cmpq $0, %rcx
    sete %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block_34
    jmp block_35

	.align 16
block_37:
    movq %r15, %rdi
    movq $16, %rsi
    movq %rcx, 0(%r15)
    movq %r8, -8(%r15)
    movq %rcx, -16(%r15)
    movq %rdx, -24(%r15)
    movq %rcx, -32(%r15)
    movq %rdx, -40(%r15)
    movq %rdx, -48(%r15)
    movq %rcx, -56(%r15)
    movq %rsi, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %r10, -40(%rbp)
    movq %r9, -48(%rbp)
    callq collect
    movq -8(%rbp), %rsi
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r8
    movq -40(%rbp), %r10
    movq -48(%rbp), %r9
    jmp block_36

	.align 16
start:
    movq $1, %rcx
    movq free_ptr(%rip), %rdx
    addq $16, %rdx
    cmpq fromspace_end(%rip), %rdx
    jl block_36
    jmp block_37

	.align 16
conclusion:
    addq $80, %rsp
    subq $64, %r15
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
    movq $0, 48(%r15)
    movq $0, 56(%r15)
    addq $64, %r15
    jmp start


