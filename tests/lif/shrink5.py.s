	.align 16
block_3:
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -24(%rbp), %rax
    addq %rax, -16(%rbp)
    movq -16(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_4:
    movq $0, -24(%rbp)
    jmp block_3

	.align 16
block_5:
    movq $2, -24(%rbp)
    jmp block_3

	.align 16
start:
    movq $4, -8(%rbp)
    jmp block_5

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


