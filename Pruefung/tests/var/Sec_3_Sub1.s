	.align 16
start:
    movq $2, -208(%rbp)
    movq $48, -216(%rbp)
    movq -208(%rbp), %rax
    subq %rax, -216(%rbp)
    movq -216(%rbp), %rax
    movq %rax, -224(%rbp)
    subq $4, -224(%rbp)
    movq -224(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $224, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $224, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


