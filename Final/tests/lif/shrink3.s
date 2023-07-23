	.align 16
block_158:
    movq $0, %rax
    jmp conclusion

	.align 16
block_159:
    movq $0, %rdi
    callq print_int
    jmp block_158

	.align 16
block_160:
    movq $1, %rdi
    callq print_int
    jmp block_158

	.align 16
start:
    jmp block_160

	.align 16
conclusion:
    addq $352, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $352, %rsp
    jmp start


