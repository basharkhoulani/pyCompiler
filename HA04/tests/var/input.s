	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $112, %rsp
    callq read_int
    movq %rax, -112(%rbp)
    movq -112(%rbp), %rdi
    callq print_int
    addq $112, %rsp
    popq %rbp
    retq 

