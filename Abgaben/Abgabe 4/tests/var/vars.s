	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $384, %rsp
    movq $1, -304(%rbp)
    addq $1, -304(%rbp)
    movq -304(%rbp), %rax
    movq %rax, -312(%rbp)
    movq -312(%rbp), %rax
    movq %rax, -320(%rbp)
    addq $1, -320(%rbp)
    movq -320(%rbp), %rax
    movq %rax, -312(%rbp)
    movq $1, -328(%rbp)
    movq -312(%rbp), %rax
    addq %rax, -328(%rbp)
    movq -328(%rbp), %rax
    movq %rax, -312(%rbp)
    movq -312(%rbp), %rax
    movq %rax, -336(%rbp)
    movq -312(%rbp), %rax
    addq %rax, -336(%rbp)
    movq -336(%rbp), %rax
    movq %rax, -312(%rbp)
    movq -312(%rbp), %rdi
    callq print_int
    movq $1, -344(%rbp)
    addq $1, -344(%rbp)
    movq -344(%rbp), %rax
    movq %rax, -352(%rbp)
    movq -312(%rbp), %rax
    movq %rax, -360(%rbp)
    addq $1, -360(%rbp)
    movq -360(%rbp), %rax
    movq %rax, -352(%rbp)
    movq $1, -368(%rbp)
    movq -352(%rbp), %rax
    addq %rax, -368(%rbp)
    movq -368(%rbp), %rax
    movq %rax, -352(%rbp)
    movq -312(%rbp), %rax
    movq %rax, -376(%rbp)
    movq -352(%rbp), %rax
    addq %rax, -376(%rbp)
    movq -376(%rbp), %rax
    movq %rax, -352(%rbp)
    movq -352(%rbp), %rdi
    callq print_int
    addq $384, %rsp
    popq %rbp
    retq 

