	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $10, %r10
    movq %r10, %r11
    addq %r10, %r11
    movq %r11, %r10
    movq %r10, %r11
    subq %r10, %r11
    movq %r10, %rdi
    movq %r11, -8(%rbp)
    callq print_int
    movq -8(%rbp), %r11
    movq %r11, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

