	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $800, %rsp
    movq %r8, -720(%rbp)
    movq %r10, -728(%rbp)
    movq %r11, -736(%rbp)
    movq %rdx, -744(%rbp)
    movq %rcx, -752(%rbp)
    movq %rsi, -760(%rbp)
    movq %r9, -768(%rbp)
    callq read_int
    movq -720(%rbp), %r8
    movq -728(%rbp), %r10
    movq -736(%rbp), %r11
    movq -744(%rbp), %rdx
    movq -752(%rbp), %rcx
    movq -760(%rbp), %rsi
    movq -768(%rbp), %r9
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %r8, -720(%rbp)
    movq %r10, -728(%rbp)
    movq %r11, -736(%rbp)
    movq %rdx, -744(%rbp)
    movq %rcx, -752(%rbp)
    movq %rsi, -760(%rbp)
    movq %r9, -768(%rbp)
    callq print_int
    movq -720(%rbp), %r8
    movq -728(%rbp), %r10
    movq -736(%rbp), %r11
    movq -744(%rbp), %rdx
    movq -752(%rbp), %rcx
    movq -760(%rbp), %rsi
    movq -768(%rbp), %r9
    addq $800, %rsp
    popq %rbp
    retq 

