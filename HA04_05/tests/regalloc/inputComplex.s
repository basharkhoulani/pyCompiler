	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    callq read_int
    movq %rax, %rsi
    addq $42, %rsi
    addq $69, %rsi
    movq %rsi, %rdx
    movq %rdx, %rsi
    addq %rdx, %rsi
    addq %rdx, %rsi
    addq %rdx, %rsi
    movq %rsi, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

