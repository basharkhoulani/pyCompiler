        .globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %rcx
    movq %rcx, -8(%rbp)
    callq read_int
    movq -8(%rbp), %rcx
    movq %rax, %rsi
    movq %rcx, %r10
    addq %rsi, %r10
    movq %r10, %r11
    movq %rcx, %r10
    subq %rsi, %r10
    movq %r11, %rdi
    movq %r10, -8(%rbp)
    movq %rcx, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %rsi, -32(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rcx
    movq -24(%rbp), %r11
    movq -32(%rbp), %rsi
    movq %r10, %rdi
    movq %r10, -8(%rbp)
    movq %rcx, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %rsi, -32(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rcx
    movq -24(%rbp), %r11
    movq -32(%rbp), %rsi
    movq %rcx, %rdi
    movq %r10, -8(%rbp)
    movq %rcx, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %rsi, -32(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rcx
    movq -24(%rbp), %r11
    movq -32(%rbp), %rsi
    movq %rsi, %rdi
    movq %r10, -8(%rbp)
    movq %rcx, -16(%rbp)
    movq %rsi, -24(%rbp)
    movq %r11, -32(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rcx
    movq -24(%rbp), %rsi
    movq -32(%rbp), %r11
    movq %r11, %rdi
    movq %r10, -8(%rbp)
    movq %rcx, -16(%rbp)
    movq %rsi, -24(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq -16(%rbp), %rcx
    movq -24(%rbp), %rsi
    movq %r10, %rdi
    movq %rcx, -8(%rbp)
    movq %rsi, -16(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq -16(%rbp), %rsi
    movq %rcx, %rdi
    movq %rsi, -8(%rbp)
    callq print_int
    movq -8(%rbp), %rsi
    movq %rsi, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 
