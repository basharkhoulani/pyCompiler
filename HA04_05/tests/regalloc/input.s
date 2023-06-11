	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    callq read_int
    movq %rax, %r11
    movq %r11, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

