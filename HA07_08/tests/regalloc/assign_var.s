	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    movq $1, %rcx
    movq %rcx, %rdi
    movq %rdx, -88(%rbp)
    movq %rsi, -96(%rbp)
    movq %r11, -104(%rbp)
    movq %rcx, -112(%rbp)
    movq %r10, -120(%rbp)
    movq %r8, -128(%rbp)
    movq %r9, -136(%rbp)
    callq print_int
    movq -88(%rbp), %rdx
    movq -96(%rbp), %rsi
    movq -104(%rbp), %r11
    movq -112(%rbp), %rcx
    movq -120(%rbp), %r10
    movq -128(%rbp), %r8
    movq -136(%rbp), %r9
    addq $160, %rsp
    popq %rbp
    retq 

