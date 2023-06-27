	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $1, %r9
    addq $1, %r9
    movq %r9, %rdx
    movq %rdx, %r9
    addq $1, %r9
    movq %r9, %rdx
    movq $1, %r9
    addq %rdx, %r9
    movq %r9, %rdx
    movq %rdx, %r9
    addq %rdx, %r9
    movq %r9, %rdx
    movq %rdx, %rdi
    movq %rdx, -8(%rbp)
    callq print_int
    movq -8(%rbp), %rdx
    movq $1, %r9
    addq $1, %r9
    movq %r9, %r11
    movq %rdx, %r9
    addq $1, %r9
    movq %r9, %r11
    movq $1, %r9
    addq %r11, %r9
    movq %r9, %r11
    movq %rdx, %r9
    addq %r11, %r9
    movq %r9, %r11
    movq %r11, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

