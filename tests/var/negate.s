	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $144, %rsp
    movq %rdi, -136(%rbp)
    callq read_int
    movq %rax, %rdi
    negq %rdi
    negq %rdi
    negq %rdi
    callq print_int
    movq -136(%rbp), %rdi
    addq $144, %rsp
    popq %rbp
    retq 

