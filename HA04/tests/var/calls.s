	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $288, %rsp
    callq read_int
    movq %rax, -176(%rbp)
    callq read_int
    movq %rax, -184(%rbp)
    movq $1, -192(%rbp)
    addq $1, -192(%rbp)
    movq -192(%rbp), %rax
    movq %rax, -200(%rbp)
    movq -176(%rbp), %rax
    movq %rax, -208(%rbp)
    movq -184(%rbp), %rax
    addq %rax, -208(%rbp)
    movq -208(%rbp), %rax
    movq %rax, -216(%rbp)
    movq -200(%rbp), %rax
    movq %rax, -224(%rbp)
    movq -216(%rbp), %rax
    addq %rax, -224(%rbp)
    movq -224(%rbp), %rax
    movq %rax, -232(%rbp)
    callq read_int
    movq %rax, -240(%rbp)
    callq read_int
    movq %rax, -248(%rbp)
    movq -240(%rbp), %rax
    movq %rax, -256(%rbp)
    movq -248(%rbp), %rax
    addq %rax, -256(%rbp)
    movq -256(%rbp), %rax
    movq %rax, -264(%rbp)
    movq -232(%rbp), %rax
    movq %rax, -272(%rbp)
    movq -264(%rbp), %rax
    subq %rax, -272(%rbp)
    movq -272(%rbp), %rax
    movq %rax, -280(%rbp)
    movq -280(%rbp), %rdi
    callq print_int
    addq $288, %rsp
    popq %rbp
    retq 

