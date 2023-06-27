	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    callq read_int
    movq %rax, %r9
    addq $42, %r9
    addq $69, %r9
    movq %r9, %r11
    movq %r11, %r9
    addq %r11, %r9
    addq %r11, %r9
    addq %r11, %r9
    movq %r9, %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

