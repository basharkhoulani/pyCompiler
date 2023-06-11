	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq $1, %rdx
    movq %rdx, -16(%rbp)
    callq read_int
    movq -16(%rbp), %rdx
    movq %rax, %r11
    addq %r11, %rdx
    addq $10, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

