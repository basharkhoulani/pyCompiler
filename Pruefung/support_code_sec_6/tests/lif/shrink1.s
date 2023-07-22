	.align 16
block_88:
    movq $0, %rax
    jmp conclusion

	.align 16
block_89:
    movq $1, %rdi
    callq print_int
    jmp block_88

	.align 16
block_90:
    movq $0, %rdi
    callq print_int
    jmp block_88

	.align 16
start:
    jmp block_89

	.align 16
conclusion:
    addq $1440, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1440, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


