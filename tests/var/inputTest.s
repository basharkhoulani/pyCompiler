	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $112, %rsp
    movq %rdi, -96(%rbp)
    movq %r10, -104(%rbp)
    movq %r11, -112(%rbp)
    movq $1, %r10
    callq read_int
    movq %rax, %r11
    movq %r10, %rdi
    addq %r11, %rdi
    addq $10, %rdi
    callq print_int
    movq -96(%rbp), %rdi
    movq -104(%rbp), %r10
    movq -112(%rbp), %r11
    addq $112, %rsp
    popq %rbp
    retq 

