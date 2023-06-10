	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $192, %rsp
    movq %rdi, -168(%rbp)
    movq %r10, -176(%rbp)
    movq %r11, -184(%rbp)
    movq $1, %rdi
    addq $1, %rdi
    addq $1, %rdi
    movq $1, %r11
    addq %rdi, %r11
    movq %r11, %rdi
    movq %rdi, %r11
    addq %rdi, %r11
    movq %r11, %rdi
    callq print_int
    movq $1, %r11
    addq $1, %r11
    movq %r11, %r10
    movq %rdi, %r11
    addq $1, %r11
    movq %r11, %r10
    movq $1, %r11
    addq %r10, %r11
    movq %r11, %r10
    movq %rdi, %r11
    addq %r10, %r11
    movq %r11, %r10
    movq %r10, %rdi
    callq print_int
    movq -168(%rbp), %rdi
    movq -176(%rbp), %r10
    movq -184(%rbp), %r11
    addq $192, %rsp
    popq %rbp
    retq 

