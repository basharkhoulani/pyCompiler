	.align 16
block_155:
    movq $0, %rax
    jmp conclusion

	.align 16
block_156:
    movq $0, %rdi
    callq print_int
    jmp block_155

	.align 16
block_157:
    movq $1, %rdi
    callq print_int
    jmp block_155

	.align 16
start:
    jmp block_157

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


