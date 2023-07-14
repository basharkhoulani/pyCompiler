	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $960, %rsp
    movq $40, %rcx
    addq $2, %rcx
    movq %rcx, %rdi
    movq %r8, -880(%rbp)
    movq %r10, -888(%rbp)
    movq %r11, -896(%rbp)
    movq %rdx, -904(%rbp)
    movq %rcx, -912(%rbp)
    movq %rsi, -920(%rbp)
    movq %r9, -928(%rbp)
    callq print_int
    movq -880(%rbp), %r8
    movq -888(%rbp), %r10
    movq -896(%rbp), %r11
    movq -904(%rbp), %rdx
    movq -912(%rbp), %rcx
    movq -920(%rbp), %rsi
    movq -928(%rbp), %r9
    addq $960, %rsp
    popq %rbp
    retq 

