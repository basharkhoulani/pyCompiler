	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $448, %rsp
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
    movq -8(%rbp), %rax
    movq %rax, -152(%rbp)
    movq -16(%rbp), %rax
    addq %rax, -152(%rbp)
    movq -152(%rbp), %rax
    movq %rax, -160(%rbp)
    movq -160(%rbp), %rax
    movq %rax, -168(%rbp)
    movq -24(%rbp), %rax
    addq %rax, -168(%rbp)
    movq -168(%rbp), %rax
    movq %rax, -176(%rbp)
    movq -176(%rbp), %rdi
    callq print_int
    movq -8(%rbp), %rax
    movq %rax, -184(%rbp)
    movq -16(%rbp), %rax
    addq %rax, -184(%rbp)
    movq -184(%rbp), %rax
    movq %rax, -192(%rbp)
    movq -192(%rbp), %rax
    movq %rax, -200(%rbp)
    movq -24(%rbp), %rax
    addq %rax, -200(%rbp)
    movq -200(%rbp), %rax
    movq %rax, -208(%rbp)
    movq -208(%rbp), %rax
    movq %rax, -216(%rbp)
    movq -32(%rbp), %rax
    addq %rax, -216(%rbp)
    movq -216(%rbp), %rax
    movq %rax, -224(%rbp)
    movq -224(%rbp), %rax
    movq %rax, -232(%rbp)
    movq -40(%rbp), %rax
    addq %rax, -232(%rbp)
    movq -232(%rbp), %rax
    movq %rax, -240(%rbp)
    movq -240(%rbp), %rax
    movq %rax, -248(%rbp)
    movq -48(%rbp), %rax
    addq %rax, -248(%rbp)
    movq -248(%rbp), %rax
    movq %rax, -256(%rbp)
    movq -256(%rbp), %rax
    movq %rax, -264(%rbp)
    movq -56(%rbp), %rax
    addq %rax, -264(%rbp)
    movq -264(%rbp), %rax
    movq %rax, -272(%rbp)
    movq -272(%rbp), %rax
    movq %rax, -280(%rbp)
    movq -64(%rbp), %rax
    addq %rax, -280(%rbp)
    movq -280(%rbp), %rax
    movq %rax, -288(%rbp)
    movq -288(%rbp), %rax
    movq %rax, -296(%rbp)
    movq -72(%rbp), %rax
    addq %rax, -296(%rbp)
    movq -296(%rbp), %rax
    movq %rax, -304(%rbp)
    movq -304(%rbp), %rax
    movq %rax, -312(%rbp)
    movq -80(%rbp), %rax
    addq %rax, -312(%rbp)
    movq -312(%rbp), %rax
    movq %rax, -320(%rbp)
    movq -320(%rbp), %rax
    movq %rax, -328(%rbp)
    movq -88(%rbp), %rax
    addq %rax, -328(%rbp)
    movq -328(%rbp), %rax
    movq %rax, -336(%rbp)
    movq -336(%rbp), %rax
    movq %rax, -344(%rbp)
    movq -96(%rbp), %rax
    addq %rax, -344(%rbp)
    movq -344(%rbp), %rax
    movq %rax, -352(%rbp)
    movq -352(%rbp), %rax
    movq %rax, -360(%rbp)
    movq -104(%rbp), %rax
    addq %rax, -360(%rbp)
    movq -360(%rbp), %rax
    movq %rax, -368(%rbp)
    movq -368(%rbp), %rax
    movq %rax, -376(%rbp)
    movq -112(%rbp), %rax
    addq %rax, -376(%rbp)
    movq -376(%rbp), %rax
    movq %rax, -384(%rbp)
    movq -384(%rbp), %rax
    movq %rax, -392(%rbp)
    movq -120(%rbp), %rax
    addq %rax, -392(%rbp)
    movq -392(%rbp), %rax
    movq %rax, -400(%rbp)
    movq -400(%rbp), %rax
    movq %rax, -408(%rbp)
    movq -128(%rbp), %rax
    addq %rax, -408(%rbp)
    movq -408(%rbp), %rax
    movq %rax, -416(%rbp)
    movq -416(%rbp), %rax
    movq %rax, -424(%rbp)
    movq -136(%rbp), %rax
    addq %rax, -424(%rbp)
    movq -424(%rbp), %rax
    movq %rax, -432(%rbp)
    movq -432(%rbp), %rax
    movq %rax, -440(%rbp)
    movq -144(%rbp), %rax
    addq %rax, -440(%rbp)
    movq -440(%rbp), %rax
    movq %rax, -448(%rbp)
    movq -448(%rbp), %rdi
    callq print_int
    addq $448, %rsp
    popq %rbp
    retq 

