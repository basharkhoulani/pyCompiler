        .globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    movq $1, %r8
    movq $2, %rdx
    addq %r8, %rdx
    addq %r8, %rdx
    movq %rdx, %r8
    movq $3, %rdx
    movq %r8, %rdi
    callq print_int
    popq %rbp
    retq 