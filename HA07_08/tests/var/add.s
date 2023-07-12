	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $40, -8(%rbp)
    addq $2, -8(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

