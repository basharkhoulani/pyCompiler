	.align 16
block_163:
    movq $0, %rax
    jmp conclusion

	.align 16
block_164:
    movq $0, %rdi
    callq print_int
    jmp block_163

	.align 16
block_165:
    movq $1, %rdi
    callq print_int
    jmp block_163

	.align 16
start:
    jmp block_165

	.align 16
conclusion:
    addq $1872, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1872, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


