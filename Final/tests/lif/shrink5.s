	.align 16
block_166:
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_167:
    movq $0, %rdx
    jmp block_166

	.align 16
block_168:
    movq $2, %rdx
    jmp block_166

	.align 16
start:
    movq $4, %rcx
    jmp block_168

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


