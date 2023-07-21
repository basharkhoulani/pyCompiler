	.align 16
block_137:
    movq -1744(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
start:
    movq $1, -1744(%rbp)
    jmp block_137

	.align 16
conclusion:
    addq $1744, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1744, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


