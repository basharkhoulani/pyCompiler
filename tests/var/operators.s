	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    movq %rdi, -144(%rbp)
    movq %r10, -152(%rbp)
    movq %r11, -160(%rbp)
    movq $10, %r10
    movq %r10, %r11
    addq %r10, %r11
    movq %r11, %r10
    movq %r10, %r11
    subq %r10, %r11
    movq %r10, %rdi
    callq print_int
    movq %r11, %rdi
    callq print_int
    movq -144(%rbp), %rdi
    movq -152(%rbp), %r10
    movq -160(%rbp), %r11
    addq $160, %rsp
    popq %rbp
    retq 

