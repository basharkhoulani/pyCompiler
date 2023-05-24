	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp
    movq $2, -8(%rbp)
    addq $2, -8(%rbp)
    movq $2, -16(%rbp)
    movq -8(%rbp), %rax
    addq %rax, -16(%rbp)
    movq $2, -24(%rbp)
    negq -24(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -32(%rbp)
    movq -24(%rbp), %rax
    subq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    movq %rax, -40(%rbp)
    subq $2, -40(%rbp)
    movq -40(%rbp), %rax
    movq %rax, -48(%rbp)
    subq $2, -48(%rbp)
    movq -48(%rbp), %rax
    movq %rax, -56(%rbp)
    subq $2, -56(%rbp)
    movq -56(%rbp), %rdi
    callq print
    addq $64, %rsp
    popq %rbp
    retq 

