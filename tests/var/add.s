	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rdi, -8(%rbp)
    movq $40, %rdi
    addq $2, %rdi
    callq print_int
    movq -8(%rbp), %rdi
    addq $16, %rsp
    popq %rbp
    retq 

