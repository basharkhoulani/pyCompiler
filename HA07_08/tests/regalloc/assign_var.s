	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    movq $1, %rcx
    movq %rcx, %rdi
    movq %r8, -8(%rbp)
    movq %r10, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %rdx, -32(%rbp)
    movq %rcx, -40(%rbp)
    movq %rsi, -48(%rbp)
    movq %r9, -56(%rbp)
    callq print_int
    movq -8(%rbp), %r8
    movq -16(%rbp), %r10
    movq -24(%rbp), %r11
    movq -32(%rbp), %rdx
    movq -40(%rbp), %rcx
    movq -48(%rbp), %rsi
    movq -56(%rbp), %r9
    addq $80, %rsp
    popq %rbp
    retq 

