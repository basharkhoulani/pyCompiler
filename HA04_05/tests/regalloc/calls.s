	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    callq read_int
    movq %rax, %r9
    movq %r9, -16(%rbp)
    callq read_int
    movq -16(%rbp), %r9
    movq %rax, %rsi
    movq $1, %rcx
    addq $1, %rcx
    movq %rcx, %r8
    movq %r9, %rcx
    addq %rsi, %rcx
    movq %rcx, %rsi
    movq %r8, %rcx
    addq %rsi, %rcx
    movq %rcx, %r8
    movq %r8, -16(%rbp)
    callq read_int
    movq -16(%rbp), %r8
    movq %rax, %rcx
    movq %rcx, -8(%rbp)
    movq %r8, -16(%rbp)
    callq read_int
    movq -8(%rbp), %rcx
    movq -16(%rbp), %r8
    movq %rax, %rsi
    addq %rsi, %rcx
    movq %rcx, %rsi
    movq %r8, %rcx
    subq %rsi, %rcx
    movq %rcx, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

