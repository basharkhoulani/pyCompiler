        .globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $176, %rsp
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
    movq $1, -160(%rbp)
    movq $1, %rsi
    movq $1, %r11
    movq $1, %rcx
    movq $1, %r10
    movq $1, %rdx
    movq $1, %r8
    movq -8(%rbp), %r9
    addq -16(%rbp), %r9
    addq -24(%rbp), %r9
    addq -32(%rbp), %r9
    addq -40(%rbp), %r9
    addq -48(%rbp), %r9
    addq -56(%rbp), %r9
    addq -64(%rbp), %r9
    addq -72(%rbp), %r9
    addq -80(%rbp), %r9
    addq -88(%rbp), %r9
    addq -96(%rbp), %r9
    addq -104(%rbp), %r9
    addq -112(%rbp), %r9
    addq -120(%rbp), %r9
    addq -128(%rbp), %r9
    addq -136(%rbp), %r9
    addq -144(%rbp), %r9
    addq -152(%rbp), %r9
    addq -160(%rbp), %r9
    addq %rsi, %r9
    addq %r11, %r9
    addq %rcx, %r9
    addq %r10, %r9
    addq %rdx, %r9
    addq %r8, %r9
    movq %r9, %rdi
    callq print_int
    addq $176, %rsp
    popq %rbp
    retq 
