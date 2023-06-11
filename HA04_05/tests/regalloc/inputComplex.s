	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    callq read_int
    movq %rax, %rcx
    addq $42, %rcx
    addq $69, %rcx
    movq %rcx, %rsi
    movq %rsi, %rcx
    addq %rsi, %rcx
    addq %rsi, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

