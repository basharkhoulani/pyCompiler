	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $400, %rsp
    movq $1, %rcx
    movq %r8, -328(%rbp)
    movq %rdx, -336(%rbp)
    movq %rcx, -344(%rbp)
    movq %r10, -352(%rbp)
    movq %rsi, -360(%rbp)
    movq %r11, -368(%rbp)
    movq %r9, -376(%rbp)
    callq read_int
    movq -328(%rbp), %r8
    movq -336(%rbp), %rdx
    movq -344(%rbp), %rcx
    movq -352(%rbp), %r10
    movq -360(%rbp), %rsi
    movq -368(%rbp), %r11
    movq -376(%rbp), %r9
    movq %rax, %rdx
    addq %rdx, %rcx
    addq $10, %rcx
    movq %rcx, %rdi
    movq %r8, -328(%rbp)
    movq %rdx, -336(%rbp)
    movq %rcx, -344(%rbp)
    movq %r10, -352(%rbp)
    movq %rsi, -360(%rbp)
    movq %r11, -368(%rbp)
    movq %r9, -376(%rbp)
    callq print_int
    movq -328(%rbp), %r8
    movq -336(%rbp), %rdx
    movq -344(%rbp), %rcx
    movq -352(%rbp), %r10
    movq -360(%rbp), %rsi
    movq -368(%rbp), %r11
    movq -376(%rbp), %r9
    addq $400, %rsp
    popq %rbp
    retq 

