	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    callq read_int
    movq %rax, %rsi
    movq %rsi, -8(%rbp)
    callq read_int
    movq -8(%rbp), %rsi
    movq %rax, %r10
    movq $1, %rdx
    addq $1, %rdx
    movq %rdx, %rcx
    movq %rsi, %rdx
    addq %r10, %rdx
    movq %rdx, %r10
    movq %rcx, %rdx
    addq %r10, %rdx
    movq %rdx, %rcx
    movq %rcx, -8(%rbp)
    callq read_int
    movq -8(%rbp), %rcx
    movq %rax, %rdx
    movq %rdx, -8(%rbp)
    movq %rcx, -16(%rbp)
    callq read_int
    movq -8(%rbp), %rdx
    movq -16(%rbp), %rcx
    movq %rax, %r10
    addq %r10, %rdx
    movq %rdx, %r10
    movq %rcx, %rdx
    subq %r10, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

