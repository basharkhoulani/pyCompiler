	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    movq $1, %rsi
    movq $1, -8(%rbp)
    movq $1, -16(%rbp)
    movq $1, -24(%rbp)
    movq $1, -32(%rbp)
    movq $1, -40(%rbp)
    movq $1, -48(%rbp)
    movq $1, -56(%rbp)
    movq $1, -64(%rbp)
    movq $1, -72(%rbp)
    movq $1, -80(%rbp)
    movq $1, -88(%rbp)
    movq $1, -96(%rbp)
    movq $1, -104(%rbp)
    movq $1, -112(%rbp)
    movq $1, -120(%rbp)
    movq $1, -128(%rbp)
    movq $1, -136(%rbp)
    movq $1, -144(%rbp)
    movq $1, -152(%rbp)
    movq $1, %r11
    movq $1, %rcx
    movq $1, %r10
    movq $1, %r8
    movq $1, %r9
    movq $1, %rdx
    addq -8(%rbp), %rsi
    addq -16(%rbp), %rsi
    addq -24(%rbp), %rsi
    addq -32(%rbp), %rsi
    addq -40(%rbp), %rsi
    addq -48(%rbp), %rsi
    addq -56(%rbp), %rsi
    addq -64(%rbp), %rsi
    addq -72(%rbp), %rsi
    addq -80(%rbp), %rsi
    addq -88(%rbp), %rsi
    addq -96(%rbp), %rsi
    addq -104(%rbp), %rsi
    addq -112(%rbp), %rsi
    addq -120(%rbp), %rsi
    addq -128(%rbp), %rsi
    addq -136(%rbp), %rsi
    addq -144(%rbp), %rsi
    addq -152(%rbp), %rsi
    addq %r11, %rsi
    addq %rcx, %rsi
    addq %r10, %rsi
    addq %r8, %rsi
    addq %r9, %rsi
    addq %rdx, %rsi
    movq %rsi, %rdi
    callq print_int
    addq $160, %rsp
    popq %rbp
    retq 

