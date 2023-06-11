	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %rsi
    addq $2, %rsi
    movq %rsi, %rcx
    movq %rcx, -16(%rbp)
    callq read_int
    movq -16(%rbp), %rcx
    movq %rax, %rsi
    addq $4, %rsi
    movq %rsi, %r10
    movq %r10, -16(%rbp)
    movq %rcx, -24(%rbp)
    callq read_int
    movq -16(%rbp), %r10
    movq -24(%rbp), %rcx
    movq %rax, %rsi
    addq $8, %rsi
    movq %rsi, %r8
    movq %r10, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r8, -32(%rbp)
    callq read_int
    movq -16(%rbp), %r10
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r8
    movq %rax, %rsi
    addq $16, %rsi
    movq %rsi, %r9
    movq %r10, -8(%rbp)
    movq %rcx, -16(%rbp)
    movq %r9, -32(%rbp)
    movq %r8, -40(%rbp)
    callq read_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rcx
    movq -32(%rbp), %r9
    movq -40(%rbp), %r8
    movq %rax, %rsi
    addq $32, %rsi
    movq %rsi, %rdx
    movq %rcx, %rsi
    addq %r10, %rsi
    addq %r8, %rsi
    addq %r9, %rsi
    addq %rdx, %rsi
    movq %rsi, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

