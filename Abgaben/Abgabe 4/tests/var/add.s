	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $304, %rsp
    movq $40, -288(%rbp)
    addq $2, -288(%rbp)
    movq -288(%rbp), %rax
    movq %rax, -296(%rbp)
    movq -296(%rbp), %rdi
    callq print_int
    addq $304, %rsp
    popq %rbp
    retq 

