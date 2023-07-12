	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $640, %rsp
    movq %rdx, -568(%rbp)
    movq %rsi, -576(%rbp)
    movq %r11, -584(%rbp)
    movq %rcx, -592(%rbp)
    movq %r10, -600(%rbp)
    movq %r8, -608(%rbp)
    movq %r9, -616(%rbp)
    callq read_int
    movq -568(%rbp), %rdx
    movq -576(%rbp), %rsi
    movq -584(%rbp), %r11
    movq -592(%rbp), %rcx
    movq -600(%rbp), %r10
    movq -608(%rbp), %r8
    movq -616(%rbp), %r9
    movq %rax, %rcx
    negq %rcx
    negq %rcx
    negq %rcx
    movq %rcx, %rdi
    movq %rdx, -568(%rbp)
    movq %rsi, -576(%rbp)
    movq %r11, -584(%rbp)
    movq %rcx, -592(%rbp)
    movq %r10, -600(%rbp)
    movq %r8, -608(%rbp)
    movq %r9, -616(%rbp)
    callq print_int
    movq -568(%rbp), %rdx
    movq -576(%rbp), %rsi
    movq -584(%rbp), %r11
    movq -592(%rbp), %rcx
    movq -600(%rbp), %r10
    movq -608(%rbp), %r8
    movq -616(%rbp), %r9
    addq $640, %rsp
    popq %rbp
    retq 

