	.align 16
block_34:
    movq free_ptr(%rip), %r11
    addq $136, free_ptr(%rip)
    movq $161, 0(%r11)
    movq %r11, -144(%rbp)
    movq -144(%rbp), %r11
    movq -152(%rbp), %rax
    movq %rax, 8(%r11)
    movq -144(%rbp), %rax
    movq %rax, -160(%rbp)
    movq -160(%rbp), %r11
    movq 8(%r11), %rax
    movq %rax, -168(%rbp)
    movq -168(%rbp), %r11
    movq 8(%r11), %rax
    movq %rax, -176(%rbp)
    movq -176(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_35:
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block_34

	.align 16
block_36:
    movq free_ptr(%rip), %r11
    addq $136, free_ptr(%rip)
    movq $33, 0(%r11)
    movq %r11, -184(%rbp)
    movq -184(%rbp), %r11
    movq -192(%rbp), %rax
    movq %rax, 8(%r11)
    movq -184(%rbp), %rax
    movq %rax, -200(%rbp)
    movq -200(%rbp), %rax
    movq %rax, -152(%rbp)
    movq free_ptr(%rip), -208(%rbp)
    movq -208(%rbp), %rax
    movq %rax, -216(%rbp)
    addq $16, -216(%rbp)
    movq fromspace_end(%rip), -224(%rbp)
    movq -224(%rbp), %rax
    cmpq %rax, -216(%rbp)
    jl block_34
    jmp block_35

	.align 16
block_37:
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block_36

	.align 16
start:
    movq $42, -192(%rbp)
    movq free_ptr(%rip), -232(%rbp)
    movq -232(%rbp), %rax
    movq %rax, -240(%rbp)
    addq $16, -240(%rbp)
    movq fromspace_end(%rip), -248(%rbp)
    movq -248(%rbp), %rax
    cmpq %rax, -240(%rbp)
    jl block_36
    jmp block_37

	.align 16
conclusion:
    addq $256, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $256, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


