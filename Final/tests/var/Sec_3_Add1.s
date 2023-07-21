	.align 16
start:
    movq $4, -264(%rbp)
    addq $4, -264(%rbp)
    movq $40, -272(%rbp)
    movq -264(%rbp), %rax
    addq %rax, -272(%rbp)
    movq -272(%rbp), %rax
    movq %rax, -280(%rbp)
    addq $2, -280(%rbp)
    movq -280(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $288, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $288, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


