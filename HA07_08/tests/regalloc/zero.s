	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1200, %rsp
    movq $0, %rdi
    movq %rdx, -1120(%rbp)
    movq %rsi, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %rcx, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %r8, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq print_int
    movq -1120(%rbp), %rdx
    movq -1128(%rbp), %rsi
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %rcx
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %r8
    movq -1168(%rbp), %r9
    addq $1200, %rsp
    popq %rbp
    retq 

