	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $10, %r11
    movq %r11, %rdx
    addq %r11, %rdx
    movq %rdx, %r11
    movq %r11, %rdx
    subq %r11, %rdx
    movq %r11, %rdi
    movq %rdx, -8(%rbp)
    callq print_int
    movq -8(%rbp), %rdx
    movq %rdx, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

