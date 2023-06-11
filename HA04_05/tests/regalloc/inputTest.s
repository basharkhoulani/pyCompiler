	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq $1, %r11
    movq %r11, -16(%rbp)
    callq read_int
    movq -16(%rbp), %r11
    movq %rax, %r10
    addq %r10, %r11
    addq $10, %r11
    movq %r11, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

