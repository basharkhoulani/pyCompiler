	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    movq $1, %r11
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
    movq $1, %r9
    movq $1, %r8
    movq $1, %rcx
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r10
    addq -8(%rbp), %r11
    addq -16(%rbp), %r11
    addq -24(%rbp), %r11
    addq -32(%rbp), %r11
    addq -40(%rbp), %r11
    addq -48(%rbp), %r11
    addq -56(%rbp), %r11
    addq -64(%rbp), %r11
    addq -72(%rbp), %r11
    addq -80(%rbp), %r11
    addq -88(%rbp), %r11
    addq -96(%rbp), %r11
    addq -104(%rbp), %r11
    addq -112(%rbp), %r11
    addq -120(%rbp), %r11
    addq -128(%rbp), %r11
    addq -136(%rbp), %r11
    addq -144(%rbp), %r11
    addq -152(%rbp), %r11
    addq %r9, %r11
    addq %r8, %r11
    addq %rcx, %r11
    addq %rdx, %r11
    addq %rsi, %r11
    addq %r10, %r11
    movq %r11, %rdi
    callq print_int
    addq $160, %rsp
    popq %rbp
    retq 

