	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $880, %rsp
    movq %r8, -800(%rbp)
    movq %r10, -808(%rbp)
    movq %r11, -816(%rbp)
    movq %rdx, -824(%rbp)
    movq %rcx, -832(%rbp)
    movq %rsi, -840(%rbp)
    movq %r9, -848(%rbp)
    callq read_int
    movq -800(%rbp), %r8
    movq -808(%rbp), %r10
    movq -816(%rbp), %r11
    movq -824(%rbp), %rdx
    movq -832(%rbp), %rcx
    movq -840(%rbp), %rsi
    movq -848(%rbp), %r9
    movq %rax, %rdx
    movq %r8, -800(%rbp)
    movq %r10, -808(%rbp)
    movq %r11, -816(%rbp)
    movq %rdx, -824(%rbp)
    movq %rcx, -832(%rbp)
    movq %rsi, -840(%rbp)
    movq %r9, -848(%rbp)
    callq read_int
    movq -800(%rbp), %r8
    movq -808(%rbp), %r10
    movq -816(%rbp), %r11
    movq -824(%rbp), %rdx
    movq -832(%rbp), %rcx
    movq -840(%rbp), %rsi
    movq -848(%rbp), %r9
    movq %rax, %rsi
    movq $1, %rcx
    addq $1, %rcx
    movq %rcx, %r8
    movq %rdx, %rcx
    addq %rsi, %rcx
    movq %r8, %rdx
    addq %rcx, %rdx
    movq %rdx, %rsi
    movq %r8, -800(%rbp)
    movq %r10, -808(%rbp)
    movq %r11, -816(%rbp)
    movq %rdx, -824(%rbp)
    movq %rcx, -832(%rbp)
    movq %rsi, -840(%rbp)
    movq %r9, -848(%rbp)
    callq read_int
    movq -800(%rbp), %r8
    movq -808(%rbp), %r10
    movq -816(%rbp), %r11
    movq -824(%rbp), %rdx
    movq -832(%rbp), %rcx
    movq -840(%rbp), %rsi
    movq -848(%rbp), %r9
    movq %rax, %rcx
    movq %r8, -800(%rbp)
    movq %r10, -808(%rbp)
    movq %r11, -816(%rbp)
    movq %rdx, -824(%rbp)
    movq %rcx, -832(%rbp)
    movq %rsi, -840(%rbp)
    movq %r9, -848(%rbp)
    callq read_int
    movq -800(%rbp), %r8
    movq -808(%rbp), %r10
    movq -816(%rbp), %r11
    movq -824(%rbp), %rdx
    movq -832(%rbp), %rcx
    movq -840(%rbp), %rsi
    movq -848(%rbp), %r9
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %rsi, %rdx
    subq %rcx, %rdx
    movq %rdx, %rcx
    movq %rcx, %rdi
    movq %r8, -800(%rbp)
    movq %r10, -808(%rbp)
    movq %r11, -816(%rbp)
    movq %rdx, -824(%rbp)
    movq %rcx, -832(%rbp)
    movq %rsi, -840(%rbp)
    movq %r9, -848(%rbp)
    callq print_int
    movq -800(%rbp), %r8
    movq -808(%rbp), %r10
    movq -816(%rbp), %r11
    movq -824(%rbp), %rdx
    movq -832(%rbp), %rcx
    movq -840(%rbp), %rsi
    movq -848(%rbp), %r9
    addq $880, %rsp
    popq %rbp
    retq 

