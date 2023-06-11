	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $10, %rsi
    movq %rsi, %rcx
    addq %rsi, %rcx
    movq %rcx, %rsi
    movq %rsi, %rcx
    subq %rsi, %rcx
    movq %rsi, %rdi
    movq %rcx, -8(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq %rcx, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

