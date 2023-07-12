	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    movq $40, %rcx
    addq $2, %rcx
    movq %rcx, %rdi
    movq %rdx, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %rcx, -32(%rbp)
    movq %r10, -40(%rbp)
    movq %r8, -48(%rbp)
    movq %r9, -56(%rbp)
    callq print_int
    movq -8(%rbp), %rdx
    movq -16(%rbp), %rsi
    movq -24(%rbp), %r11
    movq -32(%rbp), %rcx
    movq -40(%rbp), %r10
    movq -48(%rbp), %r8
    movq -56(%rbp), %r9
    addq $80, %rsp
    popq %rbp
    retq 

