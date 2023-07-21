	.align 16
start:
    movq $6, -48(%rbp)
    movq -48(%rbp), %rax
    movq %rax, -56(%rbp)
    subq $2, -56(%rbp)
    movq $2, -64(%rbp)
    negq -64(%rbp)
    movq -64(%rbp), %rax
    addq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    movq %rax, -72(%rbp)
    subq $2, -72(%rbp)
    movq -72(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $80, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


