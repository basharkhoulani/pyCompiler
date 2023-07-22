	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $40, %rsi
    addq $2, %rsi
    movq %rsi, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

