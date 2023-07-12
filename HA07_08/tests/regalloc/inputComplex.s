	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $400, %rsp
    movq %rdx, -328(%rbp)
    movq %rsi, -336(%rbp)
    movq %r11, -344(%rbp)
    movq %rcx, -352(%rbp)
    movq %r10, -360(%rbp)
    movq %r8, -368(%rbp)
    movq %r9, -376(%rbp)
    callq read_int
    movq -328(%rbp), %rdx
    movq -336(%rbp), %rsi
    movq -344(%rbp), %r11
    movq -352(%rbp), %rcx
    movq -360(%rbp), %r10
    movq -368(%rbp), %r8
    movq -376(%rbp), %r9
    movq %rax, %rcx
    addq $42, %rcx
    addq $69, %rcx
    movq %rcx, %rdx
    movq %rdx, %rcx
    addq %rdx, %rcx
    addq %rdx, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %rdx, -328(%rbp)
    movq %rsi, -336(%rbp)
    movq %r11, -344(%rbp)
    movq %rcx, -352(%rbp)
    movq %r10, -360(%rbp)
    movq %r8, -368(%rbp)
    movq %r9, -376(%rbp)
    callq print_int
    movq -328(%rbp), %rdx
    movq -336(%rbp), %rsi
    movq -344(%rbp), %r11
    movq -352(%rbp), %rcx
    movq -360(%rbp), %r10
    movq -368(%rbp), %r8
    movq -376(%rbp), %r9
    addq $400, %rsp
    popq %rbp
    retq 

