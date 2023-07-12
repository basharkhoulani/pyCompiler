	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $480, %rsp
    movq %rcx, -408(%rbp)
    movq %rdx, -416(%rbp)
    movq %r11, -424(%rbp)
    movq %r9, -432(%rbp)
    movq %r10, -440(%rbp)
    movq %rsi, -448(%rbp)
    movq %r8, -456(%rbp)
    callq read_int
    movq -408(%rbp), %rcx
    movq -416(%rbp), %rdx
    movq -424(%rbp), %r11
    movq -432(%rbp), %r9
    movq -440(%rbp), %r10
    movq -448(%rbp), %rsi
    movq -456(%rbp), %r8
    movq %rax, %rcx
    negq %rcx
    negq %rcx
    negq %rcx
    movq %rcx, %rdi
    movq %rcx, -408(%rbp)
    movq %rdx, -416(%rbp)
    movq %r11, -424(%rbp)
    movq %r9, -432(%rbp)
    movq %r10, -440(%rbp)
    movq %rsi, -448(%rbp)
    movq %r8, -456(%rbp)
    callq print_int
    movq -408(%rbp), %rcx
    movq -416(%rbp), %rdx
    movq -424(%rbp), %r11
    movq -432(%rbp), %r9
    movq -440(%rbp), %r10
    movq -448(%rbp), %rsi
    movq -456(%rbp), %r8
    addq $480, %rsp
    popq %rbp
    retq 

