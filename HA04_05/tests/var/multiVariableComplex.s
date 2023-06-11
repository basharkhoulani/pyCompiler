	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $192, %rsp
    callq read_int
    movq %rax, -8(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    addq $2, -16(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    callq read_int
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    movq %rax, -40(%rbp)
    addq $4, -40(%rbp)
    movq -40(%rbp), %rax
    movq %rax, -48(%rbp)
    callq read_int
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    movq %rax, -64(%rbp)
    addq $8, -64(%rbp)
    movq -64(%rbp), %rax
    movq %rax, -72(%rbp)
    callq read_int
    movq %rax, -80(%rbp)
    movq -80(%rbp), %rax
    movq %rax, -88(%rbp)
    addq $16, -88(%rbp)
    movq -88(%rbp), %rax
    movq %rax, -96(%rbp)
    callq read_int
    movq %rax, -104(%rbp)
    movq -104(%rbp), %rax
    movq %rax, -112(%rbp)
    addq $32, -112(%rbp)
    movq -112(%rbp), %rax
    movq %rax, -120(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -128(%rbp)
    movq -48(%rbp), %rax
    addq %rax, -128(%rbp)
    movq -128(%rbp), %rax
    movq %rax, -136(%rbp)
    movq -136(%rbp), %rax
    movq %rax, -144(%rbp)
    movq -72(%rbp), %rax
    addq %rax, -144(%rbp)
    movq -144(%rbp), %rax
    movq %rax, -152(%rbp)
    movq -152(%rbp), %rax
    movq %rax, -160(%rbp)
    movq -96(%rbp), %rax
    addq %rax, -160(%rbp)
    movq -160(%rbp), %rax
    movq %rax, -168(%rbp)
    movq -168(%rbp), %rax
    movq %rax, -176(%rbp)
    movq -120(%rbp), %rax
    addq %rax, -176(%rbp)
    movq -176(%rbp), %rax
    movq %rax, -184(%rbp)
    movq -184(%rbp), %rdi
    callq print_int
    addq $192, %rsp
    popq %rbp
    retq 

