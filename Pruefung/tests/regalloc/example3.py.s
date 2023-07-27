	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    callq read_int
    movq %rax, %rdx
    movq $1, %rsi
    movq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    callq print_int
    callq read_int
    movq %rax, %r8
    movq $1, %r9
    movq %rdx, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    movq %rcx, %rdi
    callq print_int
    callq read_int
    movq %rax, %r10
    movq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    addq %r10, %rcx
    movq %rcx, %rdi
    callq print_int
    popq %rbp
    retq 

