	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    callq read_int
    movq %rax, %rcx
    callq read_int
    movq %rax, %rdx
    addq %rdx, %rcx
    addq $42, %rcx
    movq %rcx, %rdi
    callq print_int
    popq %rbp
    retq 

