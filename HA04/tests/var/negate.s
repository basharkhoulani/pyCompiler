	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $112, %rsp
    callq read_int
    movq %rax, -88(%rbp)
    movq -88(%rbp), %rax
    movq %rax, -96(%rbp)
    negq -96(%rbp)
    negq -96(%rbp)
    movq -96(%rbp), %rax
    movq %rax, -104(%rbp)
    negq -104(%rbp)
    movq -104(%rbp), %rdi
    callq print_int
    addq $112, %rsp
    popq %rbp
    retq 

