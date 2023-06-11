	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    movq $1, %rdx
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
    movq $1, %r8
    movq $1, %rsi
    movq $1, %r9
    movq $1, %rcx
    movq $1, %r10
    movq $1, %r11
    addq -8(%rbp), %rdx
    addq -16(%rbp), %rdx
    addq -24(%rbp), %rdx
    addq -32(%rbp), %rdx
    addq -40(%rbp), %rdx
    addq -48(%rbp), %rdx
    addq -56(%rbp), %rdx
    addq -64(%rbp), %rdx
    addq -72(%rbp), %rdx
    addq -80(%rbp), %rdx
    addq -88(%rbp), %rdx
    addq -96(%rbp), %rdx
    addq -104(%rbp), %rdx
    addq -112(%rbp), %rdx
    addq -120(%rbp), %rdx
    addq -128(%rbp), %rdx
    addq -136(%rbp), %rdx
    addq -144(%rbp), %rdx
    addq -152(%rbp), %rdx
    addq %r8, %rdx
    addq %rsi, %rdx
    addq %r9, %rdx
    addq %rcx, %rdx
    addq %r10, %rdx
    addq %r11, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $160, %rsp
    popq %rbp
    retq 

