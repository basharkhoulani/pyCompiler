	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $400, %rsp
    movq $1, %rcx
    movq %r8, -328(%rbp)
    movq %r10, -336(%rbp)
    movq %r11, -344(%rbp)
    movq %rdx, -352(%rbp)
    movq %rcx, -360(%rbp)
    movq %rsi, -368(%rbp)
    movq %r9, -376(%rbp)
    callq read_int
    movq -328(%rbp), %r8
    movq -336(%rbp), %r10
    movq -344(%rbp), %r11
    movq -352(%rbp), %rdx
    movq -360(%rbp), %rcx
    movq -368(%rbp), %rsi
    movq -376(%rbp), %r9
    movq %rax, %rdx
    addq %rdx, %rcx
    addq $10, %rcx
    movq %rcx, %rdi
    movq %r8, -328(%rbp)
    movq %r10, -336(%rbp)
    movq %r11, -344(%rbp)
    movq %rdx, -352(%rbp)
    movq %rcx, -360(%rbp)
    movq %rsi, -368(%rbp)
    movq %r9, -376(%rbp)
    callq print_int
    movq -328(%rbp), %r8
    movq -336(%rbp), %r10
    movq -344(%rbp), %r11
    movq -352(%rbp), %rdx
    movq -360(%rbp), %rcx
    movq -368(%rbp), %rsi
    movq -376(%rbp), %r9
    addq $400, %rsp
    popq %rbp
    retq 

