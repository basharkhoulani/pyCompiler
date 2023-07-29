	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq $1, %rdx
    movq $0, %rcx
    movq %rdx, %rdi
    callq print_int
    movq %rcx, %rdi
    callq print_int
    movq $2, %rcx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $320, %rsp
    popq %rbp
    retq 

