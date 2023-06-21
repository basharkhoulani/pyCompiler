	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $10, %r11
    movq %r11, %r9
    addq %r11, %r9
    movq %r9, %r11
    movq %r11, %r9
    subq %r11, %r9
    movq %r11, %rdi
    movq %r9, -8(%rbp)
    callq print_int
    movq -8(%rbp), %r9
    movq %r9, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

