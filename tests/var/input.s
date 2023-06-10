	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp
    movq %rdi, -64(%rbp)
    callq read_int
    movq %rax, %rdi
    callq print_int
    movq -64(%rbp), %rdi
    addq $64, %rsp
    popq %rbp
    retq 

