	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    callq read_int
    movq %rax, %rdx
    addq $42, %rdx
    addq $69, %rdx
    movq %rdx, %r10
    movq %r10, %rdx
    addq %r10, %rdx
    addq %r10, %rdx
    addq %r10, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

