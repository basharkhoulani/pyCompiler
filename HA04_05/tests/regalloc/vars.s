	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $1, %r11
    addq $1, %r11
    movq %r11, %rsi
    movq %rsi, %r11
    addq $1, %r11
    movq %r11, %rsi
    movq $1, %r11
    addq %rsi, %r11
    movq %r11, %rsi
    movq %rsi, %r11
    addq %rsi, %r11
    movq %r11, %rsi
    movq %rsi, %rdi
    movq %rsi, -8(%rbp)
    callq print_int
    movq -8(%rbp), %rsi
    movq $1, %r11
    addq $1, %r11
    movq %r11, %r10
    movq %rsi, %r11
    addq $1, %r11
    movq %r11, %r10
    movq $1, %r11
    addq %r10, %r11
    movq %r11, %r10
    movq %rsi, %r11
    addq %r10, %r11
    movq %r11, %r10
    movq %r10, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

