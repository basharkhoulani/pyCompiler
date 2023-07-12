	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    movq $1, %rcx
    movq %rcx, %rdi
    movq %r8, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r10, -32(%rbp)
    movq %rsi, -40(%rbp)
    movq %r11, -48(%rbp)
    movq %r9, -56(%rbp)
    callq print_int
    movq -8(%rbp), %r8
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r10
    movq -40(%rbp), %rsi
    movq -48(%rbp), %r11
    movq -56(%rbp), %r9
    addq $80, %rsp
    popq %rbp
    retq 

