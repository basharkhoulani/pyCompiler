	.align 16
block_56:
    movq free_ptr(%rip), %r11
    addq $136, free_ptr(%rip)
    movq $161, 0(%r11)
    movq %r11, -256(%rbp)
    movq -256(%rbp), %r11
    movq -264(%rbp), %rax
    movq %rax, 8(%r11)
    movq -256(%rbp), %rax
    movq %rax, -272(%rbp)
    movq -272(%rbp), %r11
    movq 8(%r11), %rax
    movq %rax, -280(%rbp)
    movq -280(%rbp), %r11
    movq 16(%r11), %rax
    movq %rax, -288(%rbp)
    movq -288(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_57:
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block_56

	.align 16
block_58:
    movq free_ptr(%rip), %r11
    addq $200, free_ptr(%rip)
    movq $177, 0(%r11)
    movq %r11, -296(%rbp)
    movq -296(%rbp), %r11
    movq -304(%rbp), %rax
    movq %rax, 8(%r11)
    movq -296(%rbp), %r11
    movq -312(%rbp), %rax
    movq %rax, 16(%r11)
    movq -296(%rbp), %rax
    movq %rax, -320(%rbp)
    movq -320(%rbp), %rax
    movq %rax, -264(%rbp)
    movq free_ptr(%rip), -328(%rbp)
    movq -328(%rbp), %rax
    movq %rax, -336(%rbp)
    addq $16, -336(%rbp)
    movq fromspace_end(%rip), -344(%rbp)
    movq -344(%rbp), %rax
    cmpq %rax, -336(%rbp)
    jl block_56
    jmp block_57

	.align 16
block_59:
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block_58

	.align 16
block_60:
    movq free_ptr(%rip), %r11
    addq $136, free_ptr(%rip)
    movq $33, 0(%r11)
    movq %r11, -352(%rbp)
    movq -352(%rbp), %r11
    movq -360(%rbp), %rax
    movq %rax, 8(%r11)
    movq -352(%rbp), %rax
    movq %rax, -304(%rbp)
    movq $42, -312(%rbp)
    movq free_ptr(%rip), -368(%rbp)
    movq -368(%rbp), %rax
    movq %rax, -376(%rbp)
    addq $24, -376(%rbp)
    movq fromspace_end(%rip), -384(%rbp)
    movq -384(%rbp), %rax
    cmpq %rax, -376(%rbp)
    jl block_58
    jmp block_59

	.align 16
block_61:
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block_60

	.align 16
start:
    movq $7, -360(%rbp)
    movq free_ptr(%rip), -392(%rbp)
    movq -392(%rbp), %rax
    movq %rax, -400(%rbp)
    addq $16, -400(%rbp)
    movq fromspace_end(%rip), -408(%rbp)
    movq -408(%rbp), %rax
    cmpq %rax, -400(%rbp)
    jl block_60
    jmp block_61

	.align 16
conclusion:
    addq $416, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $416, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


