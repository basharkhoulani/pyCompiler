	.align 16
start:
    movq $1, -80(%rbp)
    movq -80(%rbp), %rax
    movq %rax, -88(%rbp)
    movq -80(%rbp), %rax
    addq %rax, -88(%rbp)
    addq $1, -88(%rbp)
    addq $1, -88(%rbp)
    movq -80(%rbp), %rax
    movq %rax, -96(%rbp)
    movq -88(%rbp), %rax
    addq %rax, -96(%rbp)
    movq -96(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $96, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $96, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


