	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %r9
    addq $2, %r9
    movq %r9, %r10
    movq %r10, -8(%rbp)
    callq read_int
    movq -8(%rbp), %r10
    movq %rax, %r9
    addq $4, %r9
    movq %r9, %rsi
    movq %rsi, -8(%rbp)
    movq %r10, -24(%rbp)
    callq read_int
    movq -8(%rbp), %rsi
    movq -24(%rbp), %r10
    movq %rax, %r9
    addq $8, %r9
    movq %r9, %r8
    movq %rsi, -8(%rbp)
    movq %r8, -24(%rbp)
    movq %r10, -32(%rbp)
    callq read_int
    movq -8(%rbp), %rsi
    movq -24(%rbp), %r8
    movq -32(%rbp), %r10
    movq %rax, %r9
    addq $16, %r9
    movq %r9, %rdx
    movq %rsi, -8(%rbp)
    movq %r10, -16(%rbp)
    movq %rdx, -32(%rbp)
    movq %r8, -40(%rbp)
    callq read_int
    movq -8(%rbp), %rsi
    movq -16(%rbp), %r10
    movq -32(%rbp), %rdx
    movq -40(%rbp), %r8
    movq %rax, %r9
    addq $32, %r9
    movq %r9, %r11
    movq %r10, %r9
    addq %rsi, %r9
    addq %r8, %r9
    addq %rdx, %r9
    addq %r11, %r9
    movq %r9, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

