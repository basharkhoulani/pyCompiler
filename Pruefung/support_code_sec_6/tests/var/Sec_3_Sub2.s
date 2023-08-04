	.align 16
start:
    movq $6, %rcx
    movq %rcx, %rdx
    subq $2, %rdx
    movq $2, %rcx
    negq %rcx
    addq %rcx, %rdx
    movq %rdx, %rcx
    subq $2, %rcx
    movq %rcx, %rdi
    movq %r10, -8(%rbp)
    movq %r8, -16(%rbp)
    movq %rsi, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %r9, -40(%rbp)
    movq %rdx, -48(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %r8
    movq -24(%rbp), %rsi
    movq -32(%rbp), %rcx
    movq -40(%rbp), %r9
    movq -48(%rbp), %rdx
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


