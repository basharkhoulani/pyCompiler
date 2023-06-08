	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $112, %rsp
    callq read_int
    movq %rax, -8(%rbp)
    callq read_int
    movq %rax, -16(%rbp)
    movq $1, -24(%rbp)
    addq $1, -24(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -32(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -40(%rbp)
    movq -16(%rbp), %rax
    addq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    movq %rax, -48(%rbp)
    movq -32(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -48(%rbp), %rax
    addq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    movq %rax, -64(%rbp)
    callq read_int
    movq %rax, -72(%rbp)
    callq read_int
    movq %rax, -80(%rbp)
    movq -72(%rbp), %rax
    movq %rax, -88(%rbp)
    movq -80(%rbp), %rax
    addq %rax, -88(%rbp)
    movq -88(%rbp), %rax
    movq %rax, -96(%rbp)
    movq -64(%rbp), %rax
    movq %rax, -104(%rbp)
    movq -96(%rbp), %rax
    subq %rax, -104(%rbp)
    movq -104(%rbp), %rax
    movq %rax, -112(%rbp)
    movq -112(%rbp), %rdi
    callq print_int
    addq $112, %rsp
    popq %rbp
    retq 

