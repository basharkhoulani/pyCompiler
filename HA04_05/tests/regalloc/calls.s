	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    callq read_int
    movq %rax, %rdx
    movq %rdx, -16(%rbp)
    callq read_int
    movq -16(%rbp), %rdx
    movq %rax, %r10
    movq $1, %r11
    addq $1, %r11
    movq %r11, %rsi
    movq %rdx, %r11
    addq %r10, %r11
    movq %r11, %r10
    movq %rsi, %r11
    addq %r10, %r11
    movq %r11, %rsi
    movq %rsi, -16(%rbp)
    callq read_int
    movq -16(%rbp), %rsi
    movq %rax, %r11
    movq %r11, -16(%rbp)
    movq %rsi, -24(%rbp)
    callq read_int
    movq -16(%rbp), %r11
    movq -24(%rbp), %rsi
    movq %rax, %r10
    addq %r10, %r11
    movq %r11, %r10
    movq %rsi, %r11
    subq %r10, %r11
    movq %r11, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

