	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $96, %rsp
    movq %rdi, -72(%rbp)
    movq %r10, -80(%rbp)
    movq %r11, -88(%rbp)
    callq read_int
    movq %rax, %r10
    addq $42, %r10
    addq $69, %r10
    movq %r10, %r11
    addq %r10, %r11
    addq %r10, %r11
    movq %r11, %rdi
    addq %r10, %rdi
    callq print_int
    movq -72(%rbp), %rdi
    movq -80(%rbp), %r10
    movq -88(%rbp), %r11
    addq $96, %rsp
    popq %rbp
    retq 

