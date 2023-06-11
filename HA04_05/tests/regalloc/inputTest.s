	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq $1, %rsi
    movq %rsi, -16(%rbp)
    callq read_int
    movq -16(%rbp), %rsi
    movq %rax, %rdx
    addq %rdx, %rsi
    addq $10, %rsi
    movq %rsi, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

