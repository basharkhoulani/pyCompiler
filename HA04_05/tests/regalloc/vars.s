	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $1, %rdx
    addq $1, %rdx
    movq %rdx, %rcx
    movq %rcx, %rdx
    addq $1, %rdx
    movq %rdx, %rcx
    movq $1, %rdx
    addq %rcx, %rdx
    movq %rdx, %rcx
    movq %rcx, %rdx
    addq %rcx, %rdx
    movq %rdx, %rcx
    movq %rcx, %rdi
    movq %rcx, -8(%rbp)
    callq print_int
    movq -8(%rbp), %rcx
    movq $1, %rdx
    addq $1, %rdx
    movq %rdx, %r10
    movq %rcx, %rdx
    addq $1, %rdx
    movq %rdx, %r10
    movq $1, %rdx
    addq %r10, %rdx
    movq %rdx, %r10
    movq %rcx, %rdx
    addq %r10, %rdx
    movq %rdx, %r10
    movq %r10, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

