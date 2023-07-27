	.align 16
block_166:
    movq $0, %rax
    jmp conclusion

	.align 16
block_167:
    movq $0, %rdi
    callq print_int
    jmp block_166

	.align 16
block_168:
    movq $1, %rdi
    callq print_int
    jmp block_166

	.align 16
start:
    jmp block_168

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


