        .globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, %rsi
    movq %rsi, %rax
    movq %rax, %rdi
    movq %rsi, %rax
    addq %rax, %rdi
    movq %rdi, %rax
    movq %rax, %r9
    movq %rsi, %rax
    movq %rax, %rdi
    movq %r9, %rax
    addq %rax, %rdi
    movq %rdi, %rax
    movq %rax, %rdi
    movq %rdi, %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 
    