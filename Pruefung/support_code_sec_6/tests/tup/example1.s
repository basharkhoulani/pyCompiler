	.align 16
block_277:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $2, 0(%r11)
    movq %r11, %rdx
    movq %rdx, %r11
    movq %rsi, 8(%r11)
    movq %rdx, %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %rdi
    movq %r10, -4320(%rbp)
    movq %r8, -4328(%rbp)
    movq %rsi, -4336(%rbp)
    movq %rcx, -4344(%rbp)
    movq %r9, -4352(%rbp)
    movq %rdx, -4360(%rbp)
    callq print_int
    movq -4320(%rbp), %r10
    movq -4328(%rbp), %r8
    movq -4336(%rbp), %rsi
    movq -4344(%rbp), %rcx
    movq -4352(%rbp), %r9
    movq -4360(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_278:
    movq %r15, %rdi
    movq $16, %rsi
    movq %rdx, 0(%r15)
    movq %rcx, -8(%r15)
    movq %r10, -4320(%rbp)
    movq %r8, -4328(%rbp)
    movq %rsi, -4336(%rbp)
    movq %rcx, -4344(%rbp)
    movq %r9, -4352(%rbp)
    movq %rdx, -4360(%rbp)
    callq collect
    movq -4320(%rbp), %r10
    movq -4328(%rbp), %r8
    movq -4336(%rbp), %rsi
    movq -4344(%rbp), %rcx
    movq -4352(%rbp), %r9
    movq -4360(%rbp), %rdx
    jmp block_277

	.align 16
start:
    movq $42, %rsi
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_277
    jmp block_278

	.align 16
conclusion:
    addq $4400, %rsp
    subq $16, %r15
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4400, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    addq $16, %r15
    jmp start


