	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $800, %rsp
    movq %rcx, -720(%rbp)
    movq %rdx, -728(%rbp)
    movq %r11, -736(%rbp)
    movq %r9, -744(%rbp)
    movq %r10, -752(%rbp)
    movq %rsi, -760(%rbp)
    movq %r8, -768(%rbp)
    callq read_int
    movq -720(%rbp), %rcx
    movq -728(%rbp), %rdx
    movq -736(%rbp), %r11
    movq -744(%rbp), %r9
    movq -752(%rbp), %r10
    movq -760(%rbp), %rsi
    movq -768(%rbp), %r8
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %rcx, -720(%rbp)
    movq %rdx, -728(%rbp)
    movq %r11, -736(%rbp)
    movq %r9, -744(%rbp)
    movq %r10, -752(%rbp)
    movq %rsi, -760(%rbp)
    movq %r8, -768(%rbp)
    callq print_int
    movq -720(%rbp), %rcx
    movq -728(%rbp), %rdx
    movq -736(%rbp), %r11
    movq -744(%rbp), %r9
    movq -752(%rbp), %r10
    movq -760(%rbp), %rsi
    movq -768(%rbp), %r8
    addq $800, %rsp
    popq %rbp
    retq 

