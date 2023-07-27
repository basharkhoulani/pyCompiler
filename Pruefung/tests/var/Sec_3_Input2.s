	.align 16
start:
    callq read_int
    movq %rax, -128(%rbp)
    callq read_int
    movq %rax, -136(%rbp)
    movq -128(%rbp), %rax
    movq %rax, -144(%rbp)
    movq -136(%rbp), %rax
    addq %rax, -144(%rbp)
    callq read_int
    movq %rax, -152(%rbp)
    movq -144(%rbp), %rax
    movq %rax, -160(%rbp)
    movq -152(%rbp), %rax
    addq %rax, -160(%rbp)
    movq -160(%rbp), %rdi
    callq print_int
    movq -160(%rbp), %rdi
    callq print_int
    movq -160(%rbp), %rdi
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
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


