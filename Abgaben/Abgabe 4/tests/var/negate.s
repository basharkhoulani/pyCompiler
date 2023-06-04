	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    callq read_int
    movq %rax, -144(%rbp)
    movq -144(%rbp), %rax
    movq %rax, -152(%rbp)
    negq -152(%rbp)
    negq -152(%rbp)
    movq -152(%rbp), %rax
    movq %rax, -160(%rbp)
    negq -160(%rbp)
    movq -160(%rbp), %rdi
    callq print_int
    addq $160, %rsp
    popq %rbp
    retq 

