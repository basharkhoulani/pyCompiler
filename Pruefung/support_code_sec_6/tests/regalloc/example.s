	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    callq read_int
    movq %rax, %rcx
    callq read_int
    movq %rax, %rdx
    addq %rdx, %rcx
    addq $42, %rcx
    movq %rcx, %rdi
    callq print_int
    addq $320, %rsp
    popq %rbp
    retq 

