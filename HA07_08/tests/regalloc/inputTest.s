	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $400, %rsp
    movq $1, %rcx
    movq %rcx, -328(%rbp)
    movq %rdx, -336(%rbp)
    movq %r11, -344(%rbp)
    movq %r9, -352(%rbp)
    movq %r10, -360(%rbp)
    movq %rsi, -368(%rbp)
    movq %r8, -376(%rbp)
    callq read_int
    movq -328(%rbp), %rcx
    movq -336(%rbp), %rdx
    movq -344(%rbp), %r11
    movq -352(%rbp), %r9
    movq -360(%rbp), %r10
    movq -368(%rbp), %rsi
    movq -376(%rbp), %r8
    movq %rax, %rdx
    addq %rdx, %rcx
    addq $10, %rcx
    movq %rcx, %rdi
    movq %rcx, -328(%rbp)
    movq %rdx, -336(%rbp)
    movq %r11, -344(%rbp)
    movq %r9, -352(%rbp)
    movq %r10, -360(%rbp)
    movq %rsi, -368(%rbp)
    movq %r8, -376(%rbp)
    callq print_int
    movq -328(%rbp), %rcx
    movq -336(%rbp), %rdx
    movq -344(%rbp), %r11
    movq -352(%rbp), %r9
    movq -360(%rbp), %r10
    movq -368(%rbp), %rsi
    movq -376(%rbp), %r8
    addq $400, %rsp
    popq %rbp
    retq 

