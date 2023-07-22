	.align 16
block_121:
    movq -1696(%rbp), %rax
    movq %rax, -1704(%rbp)
    movq -1712(%rbp), %rax
    addq %rax, -1704(%rbp)
    movq -1704(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_122:
    movq $0, -1712(%rbp)
    jmp block_121

	.align 16
block_123:
    movq $2, -1712(%rbp)
    jmp block_121

	.align 16
start:
    movq $4, -1696(%rbp)
    jmp block_123

	.align 16
conclusion:
    addq $1712, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1712, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


