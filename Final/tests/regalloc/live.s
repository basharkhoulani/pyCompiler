	.align 16
start:
    movq $1, %rdx
    movq $0, %rcx
    movq %rdx, %rdi
    callq print_int
    movq %rcx, %rdi
    callq print_int
    movq $2, %rcx
    addq %rcx, %rdx
    movq %rdx, %rdi
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


