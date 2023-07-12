	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $960, %rsp
    movq $40, %rcx
    addq $2, %rcx
    movq %rcx, %rdi
    movq %r8, -880(%rbp)
    movq %rdx, -888(%rbp)
    movq %rcx, -896(%rbp)
    movq %r10, -904(%rbp)
    movq %rsi, -912(%rbp)
    movq %r11, -920(%rbp)
    movq %r9, -928(%rbp)
    callq print_int
    movq -880(%rbp), %r8
    movq -888(%rbp), %rdx
    movq -896(%rbp), %rcx
    movq -904(%rbp), %r10
    movq -912(%rbp), %rsi
    movq -920(%rbp), %r11
    movq -928(%rbp), %r9
    addq $960, %rsp
    popq %rbp
    retq 

