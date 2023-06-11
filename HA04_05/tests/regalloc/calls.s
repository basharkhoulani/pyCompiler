	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    callq read_int
    movq %rax, %r8
    movq %r8, -16(%rbp)
    callq read_int
    movq -16(%rbp), %r8
    movq %rax, %rdx
    movq $1, %rsi
    addq $1, %rsi
    movq %rsi, %r9
    movq %r8, %rsi
    addq %rdx, %rsi
    movq %rsi, %rdx
    movq %r9, %rsi
    addq %rdx, %rsi
    movq %rsi, %r9
    movq %r9, -16(%rbp)
    callq read_int
    movq -16(%rbp), %r9
    movq %rax, %rsi
    movq %r9, -16(%rbp)
    movq %rsi, -24(%rbp)
    callq read_int
    movq -16(%rbp), %r9
    movq -24(%rbp), %rsi
    movq %rax, %rdx
    addq %rdx, %rsi
    movq %rsi, %rdx
    movq %r9, %rsi
    subq %rdx, %rsi
    movq %rsi, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

