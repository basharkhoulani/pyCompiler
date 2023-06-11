	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %rcx
    movq %rcx, -16(%rbp)
    callq read_int
    movq -16(%rbp), %rcx
    movq %rax, %r10
    movq %rcx, %rdx
    addq %r10, %rdx
    movq %rdx, %r11
    movq %rcx, %rdx
    subq %r10, %rdx
    movq %r11, %rdi
    movq %rcx, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %r10, -32(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r11
    movq -32(%rbp), %r10
    movq %rdx, %rdi
    movq %rcx, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %r10, -32(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r11
    movq -32(%rbp), %r10
    movq %rcx, %rdi
    movq %rcx, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %r10, -32(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r11
    movq -32(%rbp), %r10
    movq %r10, %rdi
    movq %rcx, -8(%rbp)
    movq %r11, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %r10, -32(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq -16(%rbp), %r11
    movq -24(%rbp), %rdx
    movq -32(%rbp), %r10
    movq %r11, %rdi
    movq %rcx, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r10, -24(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r10
    movq %rdx, %rdi
    movq %rcx, -8(%rbp)
    movq %r10, -16(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq -16(%rbp), %r10
    movq %rcx, %rdi
    movq %r10, -8(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq %r10, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

