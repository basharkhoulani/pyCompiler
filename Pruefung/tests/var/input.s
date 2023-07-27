	.align 16
start:
    callq read_int
    movq %rax, -120(%rbp)
    movq -120(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $128, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $128, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


