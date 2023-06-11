	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $10, %rdx
    movq %rdx, %rsi
    addq %rdx, %rsi
    movq %rsi, %rdx
    movq %rdx, %rsi
    subq %rdx, %rsi
    movq %rdx, %rdi
    movq %rsi, -8(%rbp)
    callq print_int
    movq -8(%rbp), %rsi
    movq %rsi, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

