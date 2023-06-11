	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %rcx
    addq $2, %rcx
    movq %rcx, %r10
    movq %r10, -16(%rbp)
    callq read_int
    movq -16(%rbp), %r10
    movq %rax, %rcx
    addq $4, %rcx
    movq %rcx, %rdx
    movq %rdx, -8(%rbp)
    movq %r10, -24(%rbp)
    callq read_int
    movq -8(%rbp), %rdx
    movq -24(%rbp), %r10
    movq %rax, %rcx
    addq $8, %rcx
    movq %rcx, %r9
    movq %rdx, -8(%rbp)
    movq %r10, -24(%rbp)
    movq %r9, -32(%rbp)
    callq read_int
    movq -8(%rbp), %rdx
    movq -24(%rbp), %r10
    movq -32(%rbp), %r9
    movq %rax, %rcx
    addq $16, %rcx
    movq %rcx, %r8
    movq %r8, -16(%rbp)
    movq %r9, -24(%rbp)
    movq %rdx, -32(%rbp)
    movq %r10, -40(%rbp)
    callq read_int
    movq -16(%rbp), %r8
    movq -24(%rbp), %r9
    movq -32(%rbp), %rdx
    movq -40(%rbp), %r10
    movq %rax, %rcx
    addq $32, %rcx
    movq %rcx, %rsi
    movq %r10, %rcx
    addq %rdx, %rcx
    addq %r9, %rcx
    addq %r8, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

