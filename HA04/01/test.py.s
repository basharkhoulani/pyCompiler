	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    movq $1, %rdi
    callq print_int
    popq %rbp
    retq 

