	.align 16
start:
    movq $1, %rcx
    movq $42, %rdx
    addq $7, %rcx
    movq %rcx, %rsi
    addq %rdx, %rsi
    negq %rcx
    movq %rsi, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    movq %r10, -1640(%rbp)
    movq %r8, -1648(%rbp)
    movq %rsi, -1656(%rbp)
    movq %rcx, -1664(%rbp)
    movq %r9, -1672(%rbp)
    movq %rdx, -1680(%rbp)
    callq print_int
    movq -1640(%rbp), %r10
    movq -1648(%rbp), %r8
    movq -1656(%rbp), %rsi
    movq -1664(%rbp), %rcx
    movq -1672(%rbp), %r9
    movq -1680(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1712, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1712, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


