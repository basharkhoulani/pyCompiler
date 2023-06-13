	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq $1, %r9
    movq %r9, -8(%rbp)
    callq read_int
    movq -8(%rbp), %r9
    movq %rax, %r11
    addq %r11, %r9
    addq $10, %r9
    movq %r9, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

