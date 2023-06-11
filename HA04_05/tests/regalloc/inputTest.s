	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq $1, %rdx
    movq %rdx, -8(%rbp)
    callq read_int
    movq -8(%rbp), %rdx
    movq %rax, %r10
    addq %r10, %rdx
    addq $10, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

