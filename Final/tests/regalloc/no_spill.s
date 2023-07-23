	.align 16
start:
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    callq print_int
    movq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $160, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    jmp start


