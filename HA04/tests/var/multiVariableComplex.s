	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $240, %rsp
    callq read_int
    movq %rax, -128(%rbp)
    movq -128(%rbp), %rax
    movq %rax, -136(%rbp)
    addq $2, -136(%rbp)
    callq read_int
    movq %rax, -144(%rbp)
    movq -144(%rbp), %rax
    movq %rax, -152(%rbp)
    addq $4, -152(%rbp)
    callq read_int
    movq %rax, -160(%rbp)
    movq -160(%rbp), %rax
    movq %rax, -168(%rbp)
    addq $8, -168(%rbp)
    callq read_int
    movq %rax, -176(%rbp)
    movq -176(%rbp), %rax
    movq %rax, -184(%rbp)
    addq $16, -184(%rbp)
    callq read_int
    movq %rax, -192(%rbp)
    movq -192(%rbp), %rax
    movq %rax, -200(%rbp)
    addq $32, -200(%rbp)
    movq -136(%rbp), %rax
    movq %rax, -208(%rbp)
    movq -152(%rbp), %rax
    addq %rax, -208(%rbp)
    movq -208(%rbp), %rax
    movq %rax, -216(%rbp)
    movq -168(%rbp), %rax
    addq %rax, -216(%rbp)
    movq -216(%rbp), %rax
    movq %rax, -224(%rbp)
    movq -184(%rbp), %rax
    addq %rax, -224(%rbp)
    movq -224(%rbp), %rax
    movq %rax, -232(%rbp)
    movq -200(%rbp), %rax
    addq %rax, -232(%rbp)
    movq -232(%rbp), %rdi
    callq print_int
    addq $240, %rsp
    popq %rbp
    retq 

