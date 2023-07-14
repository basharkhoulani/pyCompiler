	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq %r8, -248(%rbp)
    movq %r10, -256(%rbp)
    movq %r11, -264(%rbp)
    movq %rdx, -272(%rbp)
    movq %rcx, -280(%rbp)
    movq %rsi, -288(%rbp)
    movq %r9, -296(%rbp)
    callq read_int
    movq -248(%rbp), %r8
    movq -256(%rbp), %r10
    movq -264(%rbp), %r11
    movq -272(%rbp), %rdx
    movq -280(%rbp), %rcx
    movq -288(%rbp), %rsi
    movq -296(%rbp), %r9
    movq %rax, %rcx
    addq $42, %rcx
    addq $69, %rcx
    movq %rcx, %rdx
    movq %rdx, %rcx
    addq %rdx, %rcx
    addq %rdx, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %r8, -248(%rbp)
    movq %r10, -256(%rbp)
    movq %r11, -264(%rbp)
    movq %rdx, -272(%rbp)
    movq %rcx, -280(%rbp)
    movq %rsi, -288(%rbp)
    movq %r9, -296(%rbp)
    callq print_int
    movq -248(%rbp), %r8
    movq -256(%rbp), %r10
    movq -264(%rbp), %r11
    movq -272(%rbp), %rdx
    movq -280(%rbp), %rcx
    movq -288(%rbp), %rsi
    movq -296(%rbp), %r9
    addq $320, %rsp
    popq %rbp
    retq 

