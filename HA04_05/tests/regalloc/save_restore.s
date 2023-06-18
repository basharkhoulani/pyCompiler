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
    movq %rax, %rdx
    movq %r8, %r9
    addq %rdx, %r9
    movq %r9, %r11
    movq %r8, %r9
    subq %rdx, %r9
    movq %r11, %rdi
    movq %r9, -8(%rbp)
    movq %r11, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %r8, -32(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %r11
    movq -24(%rbp), %rdx
    movq -32(%rbp), %r8
    movq %r9, %rdi
    movq %r9, -8(%rbp)
    movq %r11, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %r8, -32(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %r11
    movq -24(%rbp), %rdx
    movq -32(%rbp), %r8
    movq %r8, %rdi
    movq %r9, -8(%rbp)
    movq %r11, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %r8, -32(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %r11
    movq -24(%rbp), %rdx
    movq -32(%rbp), %r8
    movq %rdx, %rdi
    movq %r9, -8(%rbp)
    movq %r11, -16(%rbp)
    movq %rdx, -24(%rbp)
    movq %r8, -32(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %r11
    movq -24(%rbp), %rdx
    movq -32(%rbp), %r8
    movq %r11, %rdi
    movq %r9, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %r8, -24(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r8
    movq %r9, %rdi
    movq %rdx, -8(%rbp)
    movq %r8, -16(%rbp)
    callq print_int
    movq -8(%rbp), %rdx
    movq -16(%rbp), %r8
    movq %r8, %rdi
    movq %rdx, -8(%rbp)
    callq print_int
    movq -8(%rbp), %rdx
    movq %rdx, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

