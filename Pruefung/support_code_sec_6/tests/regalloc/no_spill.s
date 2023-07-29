	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    callq print_int
    movq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    movq %rcx, %rdi
    callq print_int
    addq $320, %rsp
    popq %rbp
    retq 

