	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $192, %rsp
    movq %rdi, -192(%rbp)
    movq $0, %rdi
    callq print_int
    movq -192(%rbp), %rdi
    addq $192, %rsp
    popq %rbp
    retq 

