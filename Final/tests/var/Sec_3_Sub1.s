	.align 16
start:
    movq $2, %rcx
    movq $48, %rdx
    subq %rcx, %rdx
    movq %rdx, %rcx
    subq $4, %rcx
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


