	.align 16
start:
    movq $2, %rcx
    movq $2, %rdx
    addq %rdx, %rcx
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


