	.align 16
start:
    movq $0, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start

	.align 16
conclusion:
    popq %rbp
    retq 


