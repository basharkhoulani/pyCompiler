	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    movq $1, %rcx
    movq %rcx, %rdi
    movq %rcx, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %r9, -32(%rbp)
    movq %r10, -40(%rbp)
    movq %rsi, -48(%rbp)
    movq %r8, -56(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r11
    movq -32(%rbp), %r9
    movq -40(%rbp), %r10
    movq -48(%rbp), %rsi
    movq -56(%rbp), %r8
    addq $80, %rsp
    popq %rbp
    retq 

