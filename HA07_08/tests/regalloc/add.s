	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $960, %rsp
    movq $40, %rcx
    addq $2, %rcx
    movq %rcx, %rdi
    movq %rcx, -880(%rbp)
    movq %rdx, -888(%rbp)
    movq %r11, -896(%rbp)
    movq %r9, -904(%rbp)
    movq %r10, -912(%rbp)
    movq %rsi, -920(%rbp)
    movq %r8, -928(%rbp)
    callq print_int
    movq -880(%rbp), %rcx
    movq -888(%rbp), %rdx
    movq -896(%rbp), %r11
    movq -904(%rbp), %r9
    movq -912(%rbp), %r10
    movq -920(%rbp), %rsi
    movq -928(%rbp), %r8
    addq $960, %rsp
    popq %rbp
    retq 

