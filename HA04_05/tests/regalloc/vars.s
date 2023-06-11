	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $1, %rdx
    addq $1, %rdx
    movq %rdx, %r10
    movq %r10, %rdx
    addq $1, %rdx
    movq %rdx, %r10
    movq $1, %rdx
    addq %r10, %rdx
    movq %rdx, %r10
    movq %r10, %rdx
    addq %r10, %rdx
    movq %rdx, %r10
    movq %r10, %rdi
    movq %r10, -8(%rbp)
    callq print_int
    movq -8(%rbp), %r10
    movq $1, %rdx
    addq $1, %rdx
    movq %rdx, %r11
    movq %r10, %rdx
    addq $1, %rdx
    movq %rdx, %r11
    movq $1, %rdx
    addq %r11, %rdx
    movq %rdx, %r11
    movq %r10, %rdx
    addq %r11, %rdx
    movq %rdx, %r11
    movq %r11, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

