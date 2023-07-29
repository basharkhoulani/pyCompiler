	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq $1, %rcx
    callq read_int
    movq %rax, %rsi
    movq $1, %rdx
    addq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    callq print_int
    addq $320, %rsp
    popq %rbp
    retq 

