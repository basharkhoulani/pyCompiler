	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq $6, -8(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    subq $2, -16(%rbp)
    movq $2, -24(%rbp)
    negq -24(%rbp)
    movq -24(%rbp), %rax
    addq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -32(%rbp)
    subq $2, -32(%rbp)
    movq -32(%rbp), %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

