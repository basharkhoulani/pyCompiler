	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1120, %rsp
    movq $1, %rcx
    addq $1, %rcx
    movq %rcx, %rdx
    movq %rdx, %rcx
    addq $1, %rcx
    movq %rcx, %rdx
    movq $1, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdx
    movq %rdx, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdx
    movq %rdx, %rdi
    movq %rdx, -1040(%rbp)
    movq %rsi, -1048(%rbp)
    movq %r11, -1056(%rbp)
    movq %rcx, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %r8, -1080(%rbp)
    movq %r9, -1088(%rbp)
    callq print_int
    movq -1040(%rbp), %rdx
    movq -1048(%rbp), %rsi
    movq -1056(%rbp), %r11
    movq -1064(%rbp), %rcx
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %r8
    movq -1088(%rbp), %r9
    movq $1, %rcx
    addq $1, %rcx
    movq %rcx, %rsi
    movq %rdx, %rcx
    addq $1, %rcx
    movq %rcx, %rsi
    movq $1, %rcx
    addq %rsi, %rcx
    movq %rcx, %rsi
    movq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rsi
    movq %rsi, %rdi
    movq %rdx, -1040(%rbp)
    movq %rsi, -1048(%rbp)
    movq %r11, -1056(%rbp)
    movq %rcx, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %r8, -1080(%rbp)
    movq %r9, -1088(%rbp)
    callq print_int
    movq -1040(%rbp), %rdx
    movq -1048(%rbp), %rsi
    movq -1056(%rbp), %r11
    movq -1064(%rbp), %rcx
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %r8
    movq -1088(%rbp), %r9
    addq $1120, %rsp
    popq %rbp
    retq 

