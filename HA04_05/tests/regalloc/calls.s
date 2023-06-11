	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    callq read_int
    movq %rax, %rcx
    movq %rcx, -16(%rbp)
    callq read_int
    movq -16(%rbp), %rcx
    movq %rax, %r11
    movq $1, %rdx
    addq $1, %rdx
    movq %rdx, %r10
    movq %rcx, %rdx
    addq %r11, %rdx
    movq %rdx, %r11
    movq %r10, %rdx
    addq %r11, %rdx
    movq %rdx, %r10
    movq %r10, -24(%rbp)
    callq read_int
    movq -24(%rbp), %r10
    movq %rax, %rdx
    movq %rdx, -16(%rbp)
    movq %r10, -24(%rbp)
    callq read_int
    movq -16(%rbp), %rdx
    movq -24(%rbp), %r10
    movq %rax, %r11
    addq %r11, %rdx
    movq %rdx, %r11
    movq %r10, %rdx
    subq %r11, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

