	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    movq $1, -8(%rbp)
    callq read_int
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -16(%rbp), %rax
    addq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    movq %rax, -40(%rbp)
    addq $10, -40(%rbp)
    movq -40(%rbp), %rax
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

