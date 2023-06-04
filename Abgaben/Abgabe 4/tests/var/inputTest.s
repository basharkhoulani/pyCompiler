	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $144, %rsp
    movq $1, -96(%rbp)
    callq read_int
    movq %rax, -104(%rbp)
    movq -96(%rbp), %rax
    movq %rax, -112(%rbp)
    movq -104(%rbp), %rax
    addq %rax, -112(%rbp)
    movq -112(%rbp), %rax
    movq %rax, -120(%rbp)
    movq -120(%rbp), %rax
    movq %rax, -128(%rbp)
    addq $10, -128(%rbp)
    movq -128(%rbp), %rax
    movq %rax, -136(%rbp)
    movq -136(%rbp), %rdi
    callq print_int
    addq $144, %rsp
    popq %rbp
    retq 

