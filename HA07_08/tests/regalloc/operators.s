	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $720, %rsp
    movq $10, %rdx
    movq %rdx, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdx
    movq %rdx, %rcx
    subq %rdx, %rcx
    movq %rdx, %rdi
    movq %rdx, -648(%rbp)
    movq %rsi, -656(%rbp)
    movq %r11, -664(%rbp)
    movq %rcx, -672(%rbp)
    movq %r10, -680(%rbp)
    movq %r8, -688(%rbp)
    movq %r9, -696(%rbp)
    callq print_int
    movq -648(%rbp), %rdx
    movq -656(%rbp), %rsi
    movq -664(%rbp), %r11
    movq -672(%rbp), %rcx
    movq -680(%rbp), %r10
    movq -688(%rbp), %r8
    movq -696(%rbp), %r9
    movq %rcx, %rdi
    movq %rdx, -648(%rbp)
    movq %rsi, -656(%rbp)
    movq %r11, -664(%rbp)
    movq %rcx, -672(%rbp)
    movq %r10, -680(%rbp)
    movq %r8, -688(%rbp)
    movq %r9, -696(%rbp)
    callq print_int
    movq -648(%rbp), %rdx
    movq -656(%rbp), %rsi
    movq -664(%rbp), %r11
    movq -672(%rbp), %rcx
    movq -680(%rbp), %r10
    movq -688(%rbp), %r8
    movq -696(%rbp), %r9
    addq $720, %rsp
    popq %rbp
    retq 

