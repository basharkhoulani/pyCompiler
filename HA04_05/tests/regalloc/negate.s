	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    callq read_int
    movq %rax, %rdx
    negq %rdx
    negq %rdx
    negq %rdx
    movq %rdx, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

