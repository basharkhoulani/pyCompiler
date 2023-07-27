	.align 16
block_68:
    movq free_ptr(%rip), %r11
    addq $136, free_ptr(%rip)
    movq $33, 0(%r11)
    movq %r11, -416(%rbp)
    movq -416(%rbp), %r11
    movq -424(%rbp), %rax
    movq %rax, 8(%r11)
    movq -416(%rbp), %rax
    movq %rax, -432(%rbp)
    movq -432(%rbp), %r11
    movq 8(%r11), %rax
    movq %rax, -440(%rbp)
    movq -440(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_69:
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block_68

	.align 16
start:
    movq $42, -424(%rbp)
    movq free_ptr(%rip), -448(%rbp)
    movq -448(%rbp), %rax
    movq %rax, -456(%rbp)
    addq $16, -456(%rbp)
    movq fromspace_end(%rip), -464(%rbp)
    movq -464(%rbp), %rax
    cmpq %rax, -456(%rbp)
    jl block_68
    jmp block_69

	.align 16
conclusion:
    addq $464, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $464, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


