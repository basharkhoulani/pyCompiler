	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $240, %rsp
    movq $0, %rdi
    movq %r8, -168(%rbp)
    movq %rdx, -176(%rbp)
    movq %rcx, -184(%rbp)
    movq %r10, -192(%rbp)
    movq %rsi, -200(%rbp)
    movq %r11, -208(%rbp)
    movq %r9, -216(%rbp)
    callq print_int
    movq -168(%rbp), %r8
    movq -176(%rbp), %rdx
    movq -184(%rbp), %rcx
    movq -192(%rbp), %r10
    movq -200(%rbp), %rsi
    movq -208(%rbp), %r11
    movq -216(%rbp), %r9
    addq $240, %rsp
    popq %rbp
    retq 

