	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1040, %rsp
    movq $1, %rcx
    movq $1, -808(%rbp)
    movq $1, -816(%rbp)
    movq $1, -824(%rbp)
    movq $1, -832(%rbp)
    movq $1, -840(%rbp)
    movq $1, -848(%rbp)
    movq $1, -856(%rbp)
    movq $1, -864(%rbp)
    movq $1, -872(%rbp)
    movq $1, -880(%rbp)
    movq $1, -888(%rbp)
    movq $1, -896(%rbp)
    movq $1, -904(%rbp)
    movq $1, -912(%rbp)
    movq $1, -920(%rbp)
    movq $1, -928(%rbp)
    movq $1, -936(%rbp)
    movq $1, -944(%rbp)
    movq $1, -952(%rbp)
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq $1, %r9
    movq $1, %r10
    movq $1, %r11
    addq -808(%rbp), %rcx
    addq -816(%rbp), %rcx
    addq -824(%rbp), %rcx
    addq -832(%rbp), %rcx
    addq -840(%rbp), %rcx
    addq -848(%rbp), %rcx
    addq -856(%rbp), %rcx
    addq -864(%rbp), %rcx
    addq -872(%rbp), %rcx
    addq -880(%rbp), %rcx
    addq -888(%rbp), %rcx
    addq -896(%rbp), %rcx
    addq -904(%rbp), %rcx
    addq -912(%rbp), %rcx
    addq -920(%rbp), %rcx
    addq -928(%rbp), %rcx
    addq -936(%rbp), %rcx
    addq -944(%rbp), %rcx
    addq -952(%rbp), %rcx
    addq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    addq %r10, %rcx
    addq %r11, %rcx
    movq %rcx, %rdi
    movq %rdx, -960(%rbp)
    movq %rsi, -968(%rbp)
    movq %r11, -976(%rbp)
    movq %rcx, -984(%rbp)
    movq %r10, -992(%rbp)
    movq %r8, -1000(%rbp)
    movq %r9, -1008(%rbp)
    callq print_int
    movq -960(%rbp), %rdx
    movq -968(%rbp), %rsi
    movq -976(%rbp), %r11
    movq -984(%rbp), %rcx
    movq -992(%rbp), %r10
    movq -1000(%rbp), %r8
    movq -1008(%rbp), %r9
    addq $1040, %rsp
    popq %rbp
    retq 

