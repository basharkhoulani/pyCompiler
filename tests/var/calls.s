	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp
    movq %rdi, -24(%rbp)
    movq %r8, -32(%rbp)
    movq %r9, -40(%rbp)
    movq %r10, -48(%rbp)
    movq %r11, -56(%rbp)
    callq read_int
    movq %rax, %r10
    callq read_int
    movq %rax, %r8
    movq $1, %r11
    addq $1, %r11
    movq %r11, %r9
    movq %r10, %r11
    addq %r8, %r11
    movq %r11, %r10
    movq %r9, %r11
    addq %r10, %r11
    movq %r11, %r9
    callq read_int
    movq %rax, %r11
    callq read_int
    movq %rax, %r10
    addq %r10, %r11
    movq %r11, %r10
    movq %r9, %r11
    subq %r10, %r11
    movq %r11, %rdi
    callq print_int
    movq -24(%rbp), %rdi
    movq -32(%rbp), %r8
    movq -40(%rbp), %r9
    movq -48(%rbp), %r10
    movq -56(%rbp), %r11
    addq $64, %rsp
    popq %rbp
    retq 

