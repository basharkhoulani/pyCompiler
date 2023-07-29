	.align 16
block_156:
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_157:
    movq $0, %rdx
    jmp block_156

	.align 16
block_158:
    movq $2, %rdx
    jmp block_156

	.align 16
start:
    movq $4, %rcx
    jmp block_158

	.align 16
conclusion:
    addq $32, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    jmp start


