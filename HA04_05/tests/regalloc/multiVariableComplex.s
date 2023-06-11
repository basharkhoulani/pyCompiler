	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %rdx
    addq $2, %rdx
    movq %rdx, %rsi
    movq %rsi, -8(%rbp)
    callq read_int
    movq -8(%rbp), %rsi
    movq %rax, %rdx
    addq $4, %rdx
    movq %rdx, %r9
    movq %rsi, -8(%rbp)
    movq %r9, -32(%rbp)
    callq read_int
    movq -8(%rbp), %rsi
    movq -32(%rbp), %r9
    movq %rax, %rdx
    addq $8, %rdx
    movq %rdx, %rcx
    movq %rcx, -16(%rbp)
    movq %r9, -24(%rbp)
    movq %rsi, -32(%rbp)
    callq read_int
    movq -16(%rbp), %rcx
    movq -24(%rbp), %r9
    movq -32(%rbp), %rsi
    movq %rax, %rdx
    addq $16, %rdx
    movq %rdx, %r10
    movq %rcx, -16(%rbp)
    movq %r9, -24(%rbp)
    movq %rsi, -32(%rbp)
    movq %r10, -40(%rbp)
    callq read_int
    movq -16(%rbp), %rcx
    movq -24(%rbp), %r9
    movq -32(%rbp), %rsi
    movq -40(%rbp), %r10
    movq %rax, %rdx
    addq $32, %rdx
    movq %rdx, %r11
    movq %rsi, %rdx
    addq %r9, %rdx
    addq %rcx, %rdx
    addq %r10, %rdx
    addq %r11, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

