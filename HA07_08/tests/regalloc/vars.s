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
    movq %r8, -960(%rbp)
    movq %rdx, -968(%rbp)
    movq %rcx, -976(%rbp)
    movq %r10, -984(%rbp)
    movq %rsi, -992(%rbp)
    movq %r11, -1000(%rbp)
    movq %r9, -1008(%rbp)
    callq print_int
    movq -960(%rbp), %r8
    movq -968(%rbp), %rdx
    movq -976(%rbp), %rcx
    movq -984(%rbp), %r10
    movq -992(%rbp), %rsi
    movq -1000(%rbp), %r11
    movq -1008(%rbp), %r9
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
    movq %r8, -960(%rbp)
    movq %rdx, -968(%rbp)
    movq %rcx, -976(%rbp)
    movq %r10, -984(%rbp)
    movq %rsi, -992(%rbp)
    movq %r11, -1000(%rbp)
    movq %r9, -1008(%rbp)
    callq print_int
    movq -960(%rbp), %r8
    movq -968(%rbp), %rdx
    movq -976(%rbp), %rcx
    movq -984(%rbp), %r10
    movq -992(%rbp), %rsi
    movq -1000(%rbp), %r11
    movq -1008(%rbp), %r9
    addq $1040, %rsp
    popq %rbp
    retq 

