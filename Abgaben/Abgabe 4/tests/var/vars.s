	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    movq $1, -8(%rbp)
    addq $1, -8(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    addq $1, -24(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -16(%rbp)
    movq $1, -32(%rbp)
    movq -16(%rbp), %rax
    addq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -40(%rbp)
    movq -16(%rbp), %rax
    addq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rdi
    callq print_int
    movq $1, -48(%rbp)
    addq $1, -48(%rbp)
    movq -48(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -64(%rbp)
    addq $1, -64(%rbp)
    movq -64(%rbp), %rax
    movq %rax, -56(%rbp)
    movq $1, -72(%rbp)
    movq -56(%rbp), %rax
    addq %rax, -72(%rbp)
    movq -72(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -80(%rbp)
    movq -56(%rbp), %rax
    addq %rax, -80(%rbp)
    movq -80(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rdi
    callq print_int
    addq $80, %rsp
    popq %rbp
    retq 

