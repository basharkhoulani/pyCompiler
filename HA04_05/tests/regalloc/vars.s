	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $1, %rcx
    addq $1, %rcx
    movq %rcx, %r8
    movq %r8, %rcx
    addq $1, %rcx
    movq %rcx, %r8
    movq $1, %rcx
    addq %r8, %rcx
    movq %rcx, %r8
    movq %r8, %rcx
    addq %r8, %rcx
    movq %rcx, %r8
    movq %r8, %rdi
    movq %r8, -8(%rbp)
    callq print_int
    movq -8(%rbp), %r8
    movq $1, %rcx
    addq $1, %rcx
    movq %rcx, %rsi
    movq %r8, %rcx
    addq $1, %rcx
    movq %rcx, %rsi
    movq $1, %rcx
    addq %rsi, %rcx
    movq %rcx, %rsi
    movq %r8, %rcx
    addq %rsi, %rcx
    movq %rcx, %rsi
    movq %rsi, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

