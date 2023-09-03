	.align 16
start:
    movq $40, -8(%rbp)
    addq $2, -8(%rbp)
    movq -8(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    jmp start

	.align 16
conclusion:
    addq $16, %rsp
    popq %rbp
    retq 


