	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $480, %rsp
    movq %r8, -408(%rbp)
    movq %r10, -416(%rbp)
    movq %r11, -424(%rbp)
    movq %rdx, -432(%rbp)
    movq %rcx, -440(%rbp)
    movq %rsi, -448(%rbp)
    movq %r9, -456(%rbp)
    callq read_int
    movq -408(%rbp), %r8
    movq -416(%rbp), %r10
    movq -424(%rbp), %r11
    movq -432(%rbp), %rdx
    movq -440(%rbp), %rcx
    movq -448(%rbp), %rsi
    movq -456(%rbp), %r9
    movq %rax, %rcx
    negq %rcx
    negq %rcx
    negq %rcx
    movq %rcx, %rdi
    movq %r8, -408(%rbp)
    movq %r10, -416(%rbp)
    movq %r11, -424(%rbp)
    movq %rdx, -432(%rbp)
    movq %rcx, -440(%rbp)
    movq %rsi, -448(%rbp)
    movq %r9, -456(%rbp)
    callq print_int
    movq -408(%rbp), %r8
    movq -416(%rbp), %r10
    movq -424(%rbp), %r11
    movq -432(%rbp), %rdx
    movq -440(%rbp), %rcx
    movq -448(%rbp), %rsi
    movq -456(%rbp), %r9
    addq $480, %rsp
    popq %rbp
    retq 

