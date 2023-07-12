	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq %rdx, -248(%rbp)
    movq %rsi, -256(%rbp)
    movq %r11, -264(%rbp)
    movq %rcx, -272(%rbp)
    movq %r10, -280(%rbp)
    movq %r8, -288(%rbp)
    movq %r9, -296(%rbp)
    callq read_int
    movq -248(%rbp), %rdx
    movq -256(%rbp), %rsi
    movq -264(%rbp), %r11
    movq -272(%rbp), %rcx
    movq -280(%rbp), %r10
    movq -288(%rbp), %r8
    movq -296(%rbp), %r9
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %rdx, -248(%rbp)
    movq %rsi, -256(%rbp)
    movq %r11, -264(%rbp)
    movq %rcx, -272(%rbp)
    movq %r10, -280(%rbp)
    movq %r8, -288(%rbp)
    movq %r9, -296(%rbp)
    callq print_int
    movq -248(%rbp), %rdx
    movq -256(%rbp), %rsi
    movq -264(%rbp), %r11
    movq -272(%rbp), %rcx
    movq -280(%rbp), %r10
    movq -288(%rbp), %r8
    movq -296(%rbp), %r9
    addq $320, %rsp
    popq %rbp
    retq 

