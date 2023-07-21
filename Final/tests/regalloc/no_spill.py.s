	.align 16
start:
    movq $1, %rcx
    movq $1, %rcx
    movq $1, %rcx
    addq %rcx, %rcx
    movq %rcx, %rdi
    callq print_int
    addq %rcx, %rcx
    addq %rcx, %rcx
    movq %rcx, %rdi
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


