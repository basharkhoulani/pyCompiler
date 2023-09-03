	.align 16
block_18:
    movq free_ptr(%rip), %r11
    addq $136, free_ptr(%rip)
    movq $None, 0(%r11)
    movq %r11, -8(%rbp)
    movq -8(%rbp), %r11
    movq -16(%rbp), %rax
    movq %rax, 8(%r11)
    movq -8(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %r11
    movq 8(%r11), %rax
    movq %rax, -32(%rbp)
    movq -32(%rbp), %r11
    movq 16(%r11), %rax
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_19:
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block_18

	.align 16
block_20:
    movq free_ptr(%rip), %r11
    addq $200, free_ptr(%rip)
    movq $None, 0(%r11)
    movq %r11, -48(%rbp)
    movq -48(%rbp), %r11
    movq -56(%rbp), %rax
    movq %rax, 8(%r11)
    movq -48(%rbp), %r11
    movq -64(%rbp), %rax
    movq %rax, 16(%r11)
    movq -48(%rbp), %rax
    movq %rax, -72(%rbp)
    movq -72(%rbp), %rax
    movq %rax, -16(%rbp)
    movq free_ptr(%rip), -80(%rbp)
    movq -80(%rbp), %rax
    movq %rax, -88(%rbp)
    addq $16, -88(%rbp)
    movq fromspace_end(%rip), -96(%rbp)
    movq -96(%rbp), %rax
    cmpq %rax, -88(%rbp)
    jl block_18
    jmp block_19

	.align 16
block_21:
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block_20

	.align 16
block_22:
    movq free_ptr(%rip), %r11
    addq $136, free_ptr(%rip)
    movq $None, 0(%r11)
    movq %r11, -104(%rbp)
    movq -104(%rbp), %r11
    movq -112(%rbp), %rax
    movq %rax, 8(%r11)
    movq -104(%rbp), %rax
    movq %rax, -56(%rbp)
    movq $42, -64(%rbp)
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
block_23:
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block_22

	.align 16
start:
    movq $7, -112(%rbp)
    movq free_ptr(%rip), -144(%rbp)
    movq -144(%rbp), %rax
    movq %rax, -152(%rbp)
    addq $16, -152(%rbp)
    movq fromspace_end(%rip), -160(%rbp)
    movq -160(%rbp), %rax
    cmpq %rax, -152(%rbp)
    jl block_22
    jmp block_23

	.align 16
conclusion:
    addq $160, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


