	.align 16
start:
    movq $2, -240(%rbp)
    movq $2, -248(%rbp)
    movq -240(%rbp), %rax
    movq %rax, -256(%rbp)
    movq -248(%rbp), %rax
    addq %rax, -256(%rbp)
    movq -256(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $256, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $256, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


