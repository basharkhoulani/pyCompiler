	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    callq read_int
    movq %rax, %r8
    movq %r8, -16(%rbp)
    callq read_int
    movq -16(%rbp), %r8
    movq %rax, %r11
    movq $1, %r9
    addq $1, %r9
    movq %r9, %rdx
    movq %r8, %r9
    addq %r11, %r9
    movq %r9, %r11
    movq %rdx, %r9
    addq %r11, %r9
    movq %r9, %rdx
    movq %rdx, -16(%rbp)
    callq read_int
    movq -16(%rbp), %rdx
    movq %rax, %r9
    movq %r9, -8(%rbp)
    movq %rdx, -24(%rbp)
    callq read_int
    movq -8(%rbp), %r9
    movq -24(%rbp), %rdx
    movq %rax, %r11
    addq %r11, %r9
    movq %r9, %r11
    movq %rdx, %r9
    subq %r11, %r9
    movq %r9, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

