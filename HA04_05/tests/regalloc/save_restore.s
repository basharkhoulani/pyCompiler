	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %r8
    movq %r8, -16(%rbp)
    callq read_int
    movq -16(%rbp), %r8
    movq %rax, %r9
    movq %r8, %rsi
    addq %r9, %rsi
    movq %rsi, %rdx
    movq %r8, %rsi
    subq %r9, %rsi
    movq %rdx, %rdi
    movq %rsi, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r9, -24(%rbp)
    movq %r8, -32(%rbp)
    callq print_int
    movq -8(%rbp), %rsi
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r9
    movq -32(%rbp), %r8
    movq %rsi, %rdi
    movq %rsi, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r9, -24(%rbp)
    movq %r8, -32(%rbp)
    callq print_int
    movq -8(%rbp), %rsi
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r9
    movq -32(%rbp), %r8
    movq %r8, %rdi
    movq %rsi, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r9, -24(%rbp)
    movq %r8, -32(%rbp)
    callq print_int
    movq -8(%rbp), %rsi
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r9
    movq -32(%rbp), %r8
    movq %r9, %rdi
    movq %r9, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %r8, -24(%rbp)
    movq %rdx, -32(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rsi
    movq -24(%rbp), %r8
    movq -32(%rbp), %rdx
    movq %rdx, %rdi
    movq %r9, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %r8, -24(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rsi
    movq -24(%rbp), %r8
    movq %rsi, %rdi
    movq %r9, -8(%rbp)
    movq %r8, -16(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %r8
    movq %r8, %rdi
    movq %r9, -8(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq %r9, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

