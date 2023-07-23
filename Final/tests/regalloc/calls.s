	.align 16
start:
    movq $1, %rcx
    callq read_int
    movq %rax, %rsi
    movq $1, %rdx
    addq %rdx, %rcx
    addq %rsi, %rcx
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


