	.align 16
block_46:
    movq %rcx, %rdi
    movq %r9, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %r10, -264(%rbp)
    movq %r8, -272(%rbp)
    movq %rcx, -280(%rbp)
    movq %rsi, -288(%rbp)
    callq print_int
    movq -248(%rbp), %r9
    movq -256(%rbp), %rdx
    movq -264(%rbp), %r10
    movq -272(%rbp), %r8
    movq -280(%rbp), %rcx
    movq -288(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_47:
    movq $42, %rcx
    jmp block_46

	.align 16
block_48:
    movq $0, %rcx
    jmp block_46

	.align 16
block_49:
    cmpq %rcx, %rdx
    sete %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block_47
    jmp block_48

	.align 16
block_50:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rsi, 8(%r11)
    movq %rcx, %r11
    movq %r8, 16(%r11)
    cmpq %rdx, %rdx
    je block_49
    jmp block_48

	.align 16
block_51:
    movq %r15, %rdi
    movq $24, %rsi
    movq %rdx, 0(%r15)
    movq %rdx, -8(%r15)
    movq %rcx, -16(%r15)
    movq %r8, -24(%r15)
    movq %rcx, -32(%r15)
    movq %r9, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %r10, -264(%rbp)
    movq %r8, -272(%rbp)
    movq %rcx, -280(%rbp)
    movq %rsi, -288(%rbp)
    callq collect
    movq -248(%rbp), %r9
    movq -256(%rbp), %rdx
    movq -264(%rbp), %r10
    movq -272(%rbp), %r8
    movq -280(%rbp), %rcx
    movq -288(%rbp), %rsi
    jmp block_50

	.align 16
block_52:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4, 0(%r11)
    movq %r11, %r8
    movq %r8, %r11
    movq %rcx, 8(%r11)
    movq %r8, %r11
    movq %rdx, 16(%r11)
    movq %r8, %rdx
    movq $3, %rsi
    movq $7, %r8
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_50
    jmp block_51

	.align 16
block_53:
    movq %r15, %rdi
    movq $24, %rsi
    movq %rdx, 0(%r15)
    movq %rdx, -8(%r15)
    movq %rcx, -16(%r15)
    movq %r8, -24(%r15)
    movq %rcx, -32(%r15)
    movq %r9, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %r10, -264(%rbp)
    movq %r8, -272(%rbp)
    movq %rcx, -280(%rbp)
    movq %rsi, -288(%rbp)
    callq collect
    movq -248(%rbp), %r9
    movq -256(%rbp), %rdx
    movq -264(%rbp), %r10
    movq -272(%rbp), %r8
    movq -280(%rbp), %rcx
    movq -288(%rbp), %rsi
    jmp block_52

	.align 16
start:
    movq $3, %rcx
    movq $7, %rdx
    movq free_ptr(%rip), %rsi
    addq $24, %rsi
    cmpq fromspace_end(%rip), %rsi
    jl block_52
    jmp block_53

	.align 16
conclusion:
    addq $320, %rsp
    subq $40, %r15
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    movq $0, 16(%r15)
    movq $0, 24(%r15)
    movq $0, 32(%r15)
    addq $40, %r15
    jmp start


