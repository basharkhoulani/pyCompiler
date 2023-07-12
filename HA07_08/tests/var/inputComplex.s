	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $96, %rsp
    callq read_int
    movq %rax, -8(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    addq $42, -16(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -32(%rbp)
    addq $69, -32(%rbp)
    movq -32(%rbp), %rax
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    movq %rax, -48(%rbp)
    movq -40(%rbp), %rax
    addq %rax, -48(%rbp)
    movq -48(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    movq %rax, -64(%rbp)
    movq -40(%rbp), %rax
    addq %rax, -64(%rbp)
    movq -64(%rbp), %rax
    movq %rax, -72(%rbp)
    movq -72(%rbp), %rax
    movq %rax, -80(%rbp)
    movq -40(%rbp), %rax
    addq %rax, -80(%rbp)
    movq -80(%rbp), %rax
    movq %rax, -88(%rbp)
    movq -88(%rbp), %rdi
    callq print_int
    addq $96, %rsp
    popq %rbp
    retq 

