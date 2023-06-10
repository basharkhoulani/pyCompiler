	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rdi, -16(%rbp)
    movq $1, %rdi
    callq print_int
    movq -16(%rbp), %rdi
    addq $16, %rsp
    popq %rbp
    retq 

