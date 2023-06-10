	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $128, %rsp
    movq %rdi, -120(%rbp)
    movq %r11, -128(%rbp)
    callq read_int
    movq %rax, %r11
    addq $2, %r11
    callq read_int
    movq %rax, %r11
    addq $4, %r11
    callq read_int
    movq %rax, %r11
    addq $8, %r11
    callq read_int
    movq %rax, %r11
    addq $16, %r11
    callq read_int
    movq %rax, %r11
    addq $32, %r11
    addq %r11, %r11
    addq %r11, %r11
    addq %r11, %r11
    addq %r11, %r11
    movq %r11, %rdi
    callq print_int
    movq -120(%rbp), %rdi
    movq -128(%rbp), %r11
    addq $128, %rsp
    popq %rbp
    retq 

