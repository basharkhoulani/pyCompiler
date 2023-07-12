	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $240, %rsp
    movq %rdx, -168(%rbp)
    movq %rsi, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %rcx, -192(%rbp)
    movq %r10, -200(%rbp)
    movq %r8, -208(%rbp)
    movq %r9, -216(%rbp)
    callq read_int
    movq -168(%rbp), %rdx
    movq -176(%rbp), %rsi
    movq -184(%rbp), %r11
    movq -192(%rbp), %rcx
    movq -200(%rbp), %r10
    movq -208(%rbp), %r8
    movq -216(%rbp), %r9
    movq %rax, %rdx
    movq %rdx, -168(%rbp)
    movq %rsi, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %rcx, -192(%rbp)
    movq %r10, -200(%rbp)
    movq %r8, -208(%rbp)
    movq %r9, -216(%rbp)
    callq read_int
    movq -168(%rbp), %rdx
    movq -176(%rbp), %rsi
    movq -184(%rbp), %r11
    movq -192(%rbp), %rcx
    movq -200(%rbp), %r10
    movq -208(%rbp), %r8
    movq -216(%rbp), %r9
    movq %rax, %rsi
    movq $1, %rcx
    addq $1, %rcx
    movq %rcx, %r8
    movq %rdx, %rcx
    addq %rsi, %rcx
    movq %r8, %rdx
    addq %rcx, %rdx
    movq %rdx, %rsi
    movq %rdx, -168(%rbp)
    movq %rsi, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %rcx, -192(%rbp)
    movq %r10, -200(%rbp)
    movq %r8, -208(%rbp)
    movq %r9, -216(%rbp)
    callq read_int
    movq -168(%rbp), %rdx
    movq -176(%rbp), %rsi
    movq -184(%rbp), %r11
    movq -192(%rbp), %rcx
    movq -200(%rbp), %r10
    movq -208(%rbp), %r8
    movq -216(%rbp), %r9
    movq %rax, %rcx
    movq %rdx, -168(%rbp)
    movq %rsi, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %rcx, -192(%rbp)
    movq %r10, -200(%rbp)
    movq %r8, -208(%rbp)
    movq %r9, -216(%rbp)
    callq read_int
    movq -168(%rbp), %rdx
    movq -176(%rbp), %rsi
    movq -184(%rbp), %r11
    movq -192(%rbp), %rcx
    movq -200(%rbp), %r10
    movq -208(%rbp), %r8
    movq -216(%rbp), %r9
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %rsi, %rdx
    subq %rcx, %rdx
    movq %rdx, %rcx
    movq %rcx, %rdi
    movq %rdx, -168(%rbp)
    movq %rsi, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %rcx, -192(%rbp)
    movq %r10, -200(%rbp)
    movq %r8, -208(%rbp)
    movq %r9, -216(%rbp)
    callq print_int
    movq -168(%rbp), %rdx
    movq -176(%rbp), %rsi
    movq -184(%rbp), %r11
    movq -192(%rbp), %rcx
    movq -200(%rbp), %r10
    movq -208(%rbp), %r8
    movq -216(%rbp), %r9
    addq $240, %rsp
    popq %rbp
    retq 

