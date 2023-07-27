	.align 16
block_6:
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
    movq -32(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_7:
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block_6

	.align 16
start:
    movq $42, -16(%rbp)
    movq free_ptr(%rip), -40(%rbp)
    movq -40(%rbp), %rax
    movq %rax, -48(%rbp)
    addq $16, -48(%rbp)
    movq fromspace_end(%rip), -56(%rbp)
    movq -56(%rbp), %rax
    cmpq %rax, -48(%rbp)
    jl block_6
    jmp block_7

	.align 16
conclusion:
    addq $64, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


