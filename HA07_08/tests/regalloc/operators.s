	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1120, %rsp
    movq $10, %rdx
    movq %rdx, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdx
    movq %rdx, %rcx
    subq %rdx, %rcx
    movq %rdx, %rdi
    movq %rcx, -1040(%rbp)
    movq %rdx, -1048(%rbp)
    movq %r11, -1056(%rbp)
    movq %r9, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %rsi, -1080(%rbp)
    movq %r8, -1088(%rbp)
    callq print_int
    movq -1040(%rbp), %rcx
    movq -1048(%rbp), %rdx
    movq -1056(%rbp), %r11
    movq -1064(%rbp), %r9
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %rsi
    movq -1088(%rbp), %r8
    movq %rcx, %rdi
    movq %rcx, -1040(%rbp)
    movq %rdx, -1048(%rbp)
    movq %r11, -1056(%rbp)
    movq %r9, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %rsi, -1080(%rbp)
    movq %r8, -1088(%rbp)
    callq print_int
    movq -1040(%rbp), %rcx
    movq -1048(%rbp), %rdx
    movq -1056(%rbp), %r11
    movq -1064(%rbp), %r9
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %rsi
    movq -1088(%rbp), %r8
    addq $1120, %rsp
    popq %rbp
    retq 

