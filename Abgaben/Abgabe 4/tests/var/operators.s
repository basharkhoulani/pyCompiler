	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $416, %rsp
    movq $10, -384(%rbp)
    movq -384(%rbp), %rax
    movq %rax, -392(%rbp)
    movq -384(%rbp), %rax
    addq %rax, -392(%rbp)
    movq -392(%rbp), %rax
    movq %rax, -384(%rbp)
    movq -384(%rbp), %rax
    movq %rax, -400(%rbp)
    movq -384(%rbp), %rax
    subq %rax, -400(%rbp)
    movq -400(%rbp), %rax
    movq %rax, -408(%rbp)
    movq -384(%rbp), %rdi
    callq print_int
    movq -408(%rbp), %rdi
    callq print_int
    addq $416, %rsp
    popq %rbp
    retq 

