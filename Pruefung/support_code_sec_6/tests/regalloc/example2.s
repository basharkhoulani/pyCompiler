	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq $1, %rcx
    movq $42, %rdx
    addq $7, %rcx
    movq %rcx, %rsi
    addq %rdx, %rsi
    negq %rcx
    movq %rsi, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $320, %rsp
    popq %rbp
    retq 

