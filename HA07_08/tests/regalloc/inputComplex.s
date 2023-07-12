	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq %r8, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %rcx, -264(%rbp)
    movq %r10, -272(%rbp)
    movq %rsi, -280(%rbp)
    movq %r11, -288(%rbp)
    movq %r9, -296(%rbp)
    callq read_int
    movq -248(%rbp), %r8
    movq -256(%rbp), %rdx
    movq -264(%rbp), %rcx
    movq -272(%rbp), %r10
    movq -280(%rbp), %rsi
    movq -288(%rbp), %r11
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
    movq %rdx, -256(%rbp)
    movq %rcx, -264(%rbp)
    movq %r10, -272(%rbp)
    movq %rsi, -280(%rbp)
    movq %r11, -288(%rbp)
    movq %r9, -296(%rbp)
    callq print_int
    movq -248(%rbp), %r8
    movq -256(%rbp), %rdx
    movq -264(%rbp), %rcx
    movq -272(%rbp), %r10
    movq -280(%rbp), %rsi
    movq -288(%rbp), %r11
    movq -296(%rbp), %r9
    addq $320, %rsp
    popq %rbp
    retq 

