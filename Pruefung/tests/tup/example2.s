	.align 16
block_14:
    movq -8(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_15:
    movq $42, -8(%rbp)
    jmp block_14

	.align 16
block_16:
    movq $0, -8(%rbp)
    jmp block_14

	.align 16
block_17:
    movq -16(%rbp), %rax
    cmpq %rax, -24(%rbp)
    sete %al
    movzbq %al, %rax
    movq %rax, -32(%rbp)
    cmpq $0, -32(%rbp)
    je block_15
    jmp block_16

	.align 16
block_18:
    movq free_ptr(%rip), %r11
    addq $200, free_ptr(%rip)
    movq $49, 0(%r11)
    movq %r11, -40(%rbp)
    movq -40(%rbp), %r11
    movq -48(%rbp), %rax
    movq %rax, 8(%r11)
    movq -40(%rbp), %r11
    movq -56(%rbp), %rax
    movq %rax, 16(%r11)
    movq -40(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -64(%rbp), %rax
    cmpq %rax, -24(%rbp)
    je block_17
    jmp block_16

	.align 16
block_19:
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block_18

	.align 16
block_20:
    movq free_ptr(%rip), %r11
    addq $200, free_ptr(%rip)
    movq $49, 0(%r11)
    movq %r11, -72(%rbp)
    movq -72(%rbp), %r11
    movq -80(%rbp), %rax
    movq %rax, 8(%r11)
    movq -72(%rbp), %r11
    movq -88(%rbp), %rax
    movq %rax, 16(%r11)
    movq -72(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -64(%rbp)
    movq $3, -48(%rbp)
    movq $7, -56(%rbp)
    movq free_ptr(%rip), -96(%rbp)
    movq -96(%rbp), %rax
    movq %rax, -104(%rbp)
    addq $24, -104(%rbp)
    movq fromspace_end(%rip), -112(%rbp)
    movq -112(%rbp), %rax
    cmpq %rax, -104(%rbp)
    jl block_18
    jmp block_19

	.align 16
block_21:
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block_20

	.align 16
start:
    movq $3, -80(%rbp)
    movq $7, -88(%rbp)
    movq free_ptr(%rip), -120(%rbp)
    movq -120(%rbp), %rax
    movq %rax, -128(%rbp)
    addq $24, -128(%rbp)
    movq fromspace_end(%rip), -136(%rbp)
    movq -136(%rbp), %rax
    cmpq %rax, -128(%rbp)
    jl block_20
    jmp block_21

	.align 16
conclusion:
    addq $144, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $144, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


