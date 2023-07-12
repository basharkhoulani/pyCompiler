	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1040, %rsp
    movq $1, %rcx
    addq $1, %rcx
    movq %rcx, %rdx
    movq %rdx, %rcx
    addq $1, %rcx
    movq %rcx, %rdx
    movq $1, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdx
    movq %rdx, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdx
    movq %rdx, %rdi
    movq %rcx, -960(%rbp)
    movq %rdx, -968(%rbp)
    movq %r11, -976(%rbp)
    movq %r9, -984(%rbp)
    movq %r10, -992(%rbp)
    movq %rsi, -1000(%rbp)
    movq %r8, -1008(%rbp)
    callq print_int
    movq -960(%rbp), %rcx
    movq -968(%rbp), %rdx
    movq -976(%rbp), %r11
    movq -984(%rbp), %r9
    movq -992(%rbp), %r10
    movq -1000(%rbp), %rsi
    movq -1008(%rbp), %r8
    movq $1, %rcx
    addq $1, %rcx
    movq %rcx, %rsi
    movq %rdx, %rcx
    addq $1, %rcx
    movq %rcx, %rsi
    movq $1, %rcx
    addq %rsi, %rcx
    movq %rcx, %rsi
    movq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rsi
    movq %rsi, %rdi
    movq %rcx, -960(%rbp)
    movq %rdx, -968(%rbp)
    movq %r11, -976(%rbp)
    movq %r9, -984(%rbp)
    movq %r10, -992(%rbp)
    movq %rsi, -1000(%rbp)
    movq %r8, -1008(%rbp)
    callq print_int
    movq -960(%rbp), %rcx
    movq -968(%rbp), %rdx
    movq -976(%rbp), %r11
    movq -984(%rbp), %r9
    movq -992(%rbp), %r10
    movq -1000(%rbp), %rsi
    movq -1008(%rbp), %r8
    addq $1040, %rsp
    popq %rbp
    retq 

