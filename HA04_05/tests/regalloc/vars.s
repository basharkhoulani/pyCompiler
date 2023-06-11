	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $1, %rsi
    addq $1, %rsi
    movq %rsi, %r9
    movq %r9, %rsi
    addq $1, %rsi
    movq %rsi, %r9
    movq $1, %rsi
    addq %r9, %rsi
    movq %rsi, %r9
    movq %r9, %rsi
    addq %r9, %rsi
    movq %rsi, %r9
    movq %r9, %rdi
    movq %r9, -8(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq $1, %rsi
    addq $1, %rsi
    movq %rsi, %rdx
    movq %r9, %rsi
    addq $1, %rsi
    movq %rsi, %rdx
    movq $1, %rsi
    addq %rdx, %rsi
    movq %rsi, %rdx
    movq %r9, %rsi
    addq %rdx, %rsi
    movq %rsi, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

