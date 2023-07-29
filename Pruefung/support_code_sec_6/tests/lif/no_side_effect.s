	.align 16
start:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    movq $0, %rdi
    callq print_int
    movq $5, %rcx
    addq $6, %rcx
    addq $7, %rcx
    movq $0, %rax
    jmp conclusion

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


