	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq $1, %rcx
    movq %rcx, -8(%rbp)
    callq read_int
    movq -8(%rbp), %rcx
    movq %rax, %rsi
    addq %rsi, %rcx
    addq $10, %rcx
    movq %rcx, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

