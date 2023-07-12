	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $240, %rsp
    movq $0, %rdi
    movq %rcx, -168(%rbp)
    movq %rdx, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %r9, -192(%rbp)
    movq %r10, -200(%rbp)
    movq %rsi, -208(%rbp)
    movq %r8, -216(%rbp)
    callq print_int
    movq -168(%rbp), %rcx
    movq -176(%rbp), %rdx
    movq -184(%rbp), %r11
    movq -192(%rbp), %r9
    movq -200(%rbp), %r10
    movq -208(%rbp), %rsi
    movq -216(%rbp), %r8
    addq $240, %rsp
    popq %rbp
    retq 

