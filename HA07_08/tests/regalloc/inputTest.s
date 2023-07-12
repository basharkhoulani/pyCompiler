	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $480, %rsp
    movq $1, %rcx
    movq %rdx, -408(%rbp)
    movq %rsi, -416(%rbp)
    movq %r11, -424(%rbp)
    movq %rcx, -432(%rbp)
    movq %r10, -440(%rbp)
    movq %r8, -448(%rbp)
    movq %r9, -456(%rbp)
    callq read_int
    movq -408(%rbp), %rdx
    movq -416(%rbp), %rsi
    movq -424(%rbp), %r11
    movq -432(%rbp), %rcx
    movq -440(%rbp), %r10
    movq -448(%rbp), %r8
    movq -456(%rbp), %r9
    movq %rax, %rdx
    addq %rdx, %rcx
    addq $10, %rcx
    movq %rcx, %rdi
    movq %rdx, -408(%rbp)
    movq %rsi, -416(%rbp)
    movq %r11, -424(%rbp)
    movq %rcx, -432(%rbp)
    movq %r10, -440(%rbp)
    movq %r8, -448(%rbp)
    movq %r9, -456(%rbp)
    callq print_int
    movq -408(%rbp), %rdx
    movq -416(%rbp), %rsi
    movq -424(%rbp), %r11
    movq -432(%rbp), %rcx
    movq -440(%rbp), %r10
    movq -448(%rbp), %r8
    movq -456(%rbp), %r9
    addq $480, %rsp
    popq %rbp
    retq 

