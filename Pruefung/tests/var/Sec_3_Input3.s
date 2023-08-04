	.align 16
start:
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r10, -32(%rbp)
    movq %r8, -40(%rbp)
    movq %rsi, -48(%rbp)
    callq read_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r10
    movq -40(%rbp), %r8
    movq -48(%rbp), %rsi
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r10, -32(%rbp)
    movq %r8, -40(%rbp)
    movq %rsi, -48(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r10
    movq -40(%rbp), %r8
    movq -48(%rbp), %rsi
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r10, -32(%rbp)
    movq %r8, -40(%rbp)
    movq %rsi, -48(%rbp)
    callq read_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r10
    movq -40(%rbp), %r8
    movq -48(%rbp), %rsi
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r10, -32(%rbp)
    movq %r8, -40(%rbp)
    movq %rsi, -48(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r10
    movq -40(%rbp), %r8
    movq -48(%rbp), %rsi
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r10, -32(%rbp)
    movq %r8, -40(%rbp)
    movq %rsi, -48(%rbp)
    callq read_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r10
    movq -40(%rbp), %r8
    movq -48(%rbp), %rsi
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r10, -32(%rbp)
    movq %r8, -40(%rbp)
    movq %rsi, -48(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r10
    movq -40(%rbp), %r8
    movq -48(%rbp), %rsi
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


