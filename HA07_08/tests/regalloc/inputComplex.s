	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq %rcx, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %r11, -264(%rbp)
    movq %r9, -272(%rbp)
    movq %r10, -280(%rbp)
    movq %rsi, -288(%rbp)
    movq %r8, -296(%rbp)
    callq read_int
    movq -248(%rbp), %rcx
    movq -256(%rbp), %rdx
    movq -264(%rbp), %r11
    movq -272(%rbp), %r9
    movq -280(%rbp), %r10
    movq -288(%rbp), %rsi
    movq -296(%rbp), %r8
    movq %rax, %rcx
    addq $42, %rcx
    addq $69, %rcx
    movq %rcx, %rdx
    movq %rdx, %rcx
    addq %rdx, %rcx
    addq %rdx, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %rcx, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %r11, -264(%rbp)
    movq %r9, -272(%rbp)
    movq %r10, -280(%rbp)
    movq %rsi, -288(%rbp)
    movq %r8, -296(%rbp)
    callq print_int
    movq -248(%rbp), %rcx
    movq -256(%rbp), %rdx
    movq -264(%rbp), %r11
    movq -272(%rbp), %r9
    movq -280(%rbp), %r10
    movq -288(%rbp), %rsi
    movq -296(%rbp), %r8
    addq $320, %rsp
    popq %rbp
    retq 

