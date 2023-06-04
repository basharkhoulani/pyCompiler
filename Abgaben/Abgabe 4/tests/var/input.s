	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $176, %rsp
    callq read_int
    movq %rax, -168(%rbp)
    movq -168(%rbp), %rdi
    callq print_int
    addq $176, %rsp
    popq %rbp
    retq 

