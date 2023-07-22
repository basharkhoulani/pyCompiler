	.align 16
start:
    movq $1, -8(%rbp)
    addq $2, -8(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    addq $3, -16(%rbp)
    movq $0, %rdi
    callq print_int
    movq $5, -24(%rbp)
    addq $6, -24(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -32(%rbp)
    addq $7, -32(%rbp)
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    jmp start

	.align 16
conclusion:
    addq $32, %rsp
    popq %rbp
    retq 


