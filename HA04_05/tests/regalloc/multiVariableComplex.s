	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %r11
    addq $2, %r11
    movq %r11, %r8
    movq %r8, -16(%rbp)
    callq read_int
    movq -16(%rbp), %r8
    movq %rax, %r11
    addq $4, %r11
    movq %r11, %rcx
    movq %r8, -16(%rbp)
    movq %rcx, -24(%rbp)
    callq read_int
    movq -16(%rbp), %r8
    movq -24(%rbp), %rcx
    movq %rax, %r11
    addq $8, %r11
    movq %r11, %rdx
    movq %r8, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %rcx, -32(%rbp)
    callq read_int
    movq -16(%rbp), %r8
    movq -24(%rbp), %rdx
    movq -32(%rbp), %rcx
    movq %rax, %r11
    addq $16, %r11
    movq %r11, %rsi
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %rsi, -40(%rbp)
    callq read_int
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r8
    movq -40(%rbp), %rsi
    movq %rax, %r11
    addq $32, %r11
    movq %r11, %r10
    movq %r8, %r11
    addq %rcx, %r11
    addq %rdx, %r11
    addq %rsi, %r11
    addq %r10, %r11
    movq %r11, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

