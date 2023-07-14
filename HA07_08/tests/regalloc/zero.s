	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $240, %rsp
    movq $0, %rdi
    movq %r8, -168(%rbp)
    movq %r10, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %rdx, -192(%rbp)
    movq %rcx, -200(%rbp)
    movq %rsi, -208(%rbp)
    movq %r9, -216(%rbp)
    callq print_int
    movq -168(%rbp), %r8
    movq -176(%rbp), %r10
    movq -184(%rbp), %r11
    movq -192(%rbp), %rdx
    movq -200(%rbp), %rcx
    movq -208(%rbp), %rsi
    movq -216(%rbp), %r9
    addq $240, %rsp
    popq %rbp
    retq 

