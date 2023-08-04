	.align 16
start:
    movq %r10, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %r8, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %rdx, -40(%rbp)
    movq %r9, -48(%rbp)
    callq read_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rsi
    movq -24(%rbp), %r8
    movq -32(%rbp), %rcx
    movq -40(%rbp), %rdx
    movq -48(%rbp), %r9
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %r10, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %r8, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %rdx, -40(%rbp)
    movq %r9, -48(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rsi
    movq -24(%rbp), %r8
    movq -32(%rbp), %rcx
    movq -40(%rbp), %rdx
    movq -48(%rbp), %r9
    movq %r10, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %r8, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %rdx, -40(%rbp)
    movq %r9, -48(%rbp)
    callq read_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rsi
    movq -24(%rbp), %r8
    movq -32(%rbp), %rcx
    movq -40(%rbp), %rdx
    movq -48(%rbp), %r9
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %r10, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %r8, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %rdx, -40(%rbp)
    movq %r9, -48(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rsi
    movq -24(%rbp), %r8
    movq -32(%rbp), %rcx
    movq -40(%rbp), %rdx
    movq -48(%rbp), %r9
    movq %r10, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %r8, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %rdx, -40(%rbp)
    movq %r9, -48(%rbp)
    callq read_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rsi
    movq -24(%rbp), %r8
    movq -32(%rbp), %rcx
    movq -40(%rbp), %rdx
    movq -48(%rbp), %r9
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %r10, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %r8, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %rdx, -40(%rbp)
    movq %r9, -48(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rsi
    movq -24(%rbp), %r8
    movq -32(%rbp), %rcx
    movq -40(%rbp), %rdx
    movq -48(%rbp), %r9
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


