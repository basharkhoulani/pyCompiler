	.align 16
block_7:
    movq -8(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_8:
    movq $1, -16(%rbp)
    addq $2, -16(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -8(%rbp)
    addq $3, -8(%rbp)
    jmp block_7

	.align 16
block_9:
    movq $1, -24(%rbp)
    negq -24(%rbp)
    movq $2, -32(%rbp)
    negq -32(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -40(%rbp)
    movq -32(%rbp), %rax
    addq %rax, -40(%rbp)
    movq $3, -48(%rbp)
    negq -48(%rbp)
    movq -40(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -48(%rbp), %rax
    addq %rax, -8(%rbp)
    jmp block_7

	.align 16
start:
    movq $4, -56(%rbp)
    addq $2, -56(%rbp)
    cmpq $0, -56(%rbp)
    jg block_8
    jmp block_9

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp
    jmp start

	.align 16
conclusion:
    addq $64, %rsp
    popq %rbp
    retq 


