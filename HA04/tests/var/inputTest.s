	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    movq $1, -56(%rbp)
    callq read_int
    movq %rax, -64(%rbp)
    movq -56(%rbp), %rax
    movq %rax, -72(%rbp)
    movq -64(%rbp), %rax
    addq %rax, -72(%rbp)
    movq -72(%rbp), %rax
    movq %rax, -80(%rbp)
    addq $10, -80(%rbp)
    movq -80(%rbp), %rdi
    callq print_int
    addq $80, %rsp
    popq %rbp
    retq 

