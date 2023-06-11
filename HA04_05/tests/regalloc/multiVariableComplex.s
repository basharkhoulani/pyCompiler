	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %rdx
    addq $2, %rdx
    movq %rdx, %r8
    movq %r8, -8(%rbp)
    callq read_int
    movq -8(%rbp), %r8
    movq %rax, %rdx
    addq $4, %rdx
    movq %rdx, %r11
    movq %r11, -8(%rbp)
    movq %r8, -16(%rbp)
    callq read_int
    movq -8(%rbp), %r11
    movq -16(%rbp), %r8
    movq %rax, %rdx
    addq $8, %rdx
    movq %rdx, %rsi
    movq %rsi, -8(%rbp)
    movq %r11, -16(%rbp)
    movq %r8, -24(%rbp)
    callq read_int
    movq -8(%rbp), %rsi
    movq -16(%rbp), %r11
    movq -24(%rbp), %r8
    movq %rax, %rdx
    addq $16, %rdx
    movq %rdx, %rcx
    movq %rsi, -8(%rbp)
    movq %r11, -16(%rbp)
    movq %r8, -24(%rbp)
    movq %rcx, -40(%rbp)
    callq read_int
    movq -8(%rbp), %rsi
    movq -16(%rbp), %r11
    movq -24(%rbp), %r8
    movq -40(%rbp), %rcx
    movq %rax, %rdx
    addq $32, %rdx
    movq %rdx, %r10
    movq %r8, %rdx
    addq %r11, %rdx
    addq %rsi, %rdx
    addq %rcx, %rdx
    addq %r10, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

