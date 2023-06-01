	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $128, %rsp
    movq $40, -120(%rbp)
    addq $2, -120(%rbp)
    movq -120(%rbp), %rdi
    callq print_int
    addq $128, %rsp
    popq %rbp
    retq 

