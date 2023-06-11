	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $10, %r10
    movq %r10, %rdx
    addq %r10, %rdx
    movq %rdx, %r10
    movq %r10, %rdx
    subq %r10, %rdx
    movq %r10, %rdi
    movq %rdx, -8(%rbp)
    callq print_int
    movq -8(%rbp), %rdx
    movq %rdx, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

