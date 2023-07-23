	.align 16
start:
    movq $4, %rcx
    addq $4, %rcx
    movq $40, %rdx
    addq %rcx, %rdx
    movq %rdx, %rcx
    addq $2, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


