	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
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
    popq %rbp
    retq 

