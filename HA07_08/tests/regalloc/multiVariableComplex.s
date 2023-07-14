	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1200, %rsp
    movq %r8, -1120(%rbp)
    movq %r10, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %rdx, -1144(%rbp)
    movq %rcx, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %r8
    movq -1128(%rbp), %r10
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %rdx
    movq -1152(%rbp), %rcx
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r9
    movq %rax, %rcx
    addq $2, %rcx
    movq %rcx, %rdx
    movq %r8, -1120(%rbp)
    movq %r10, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %rdx, -1144(%rbp)
    movq %rcx, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %r8
    movq -1128(%rbp), %r10
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %rdx
    movq -1152(%rbp), %rcx
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r9
    movq %rax, %rcx
    addq $4, %rcx
    movq %rcx, %rsi
    movq %r8, -1120(%rbp)
    movq %r10, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %rdx, -1144(%rbp)
    movq %rcx, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %r8
    movq -1128(%rbp), %r10
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %rdx
    movq -1152(%rbp), %rcx
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r9
    movq %rax, %rcx
    addq $8, %rcx
    movq %rcx, %r8
    movq %r8, -1120(%rbp)
    movq %r10, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %rdx, -1144(%rbp)
    movq %rcx, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %r8
    movq -1128(%rbp), %r10
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %rdx
    movq -1152(%rbp), %rcx
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r9
    movq %rax, %rcx
    addq $16, %rcx
    movq %rcx, %r9
    movq %r8, -1120(%rbp)
    movq %r10, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %rdx, -1144(%rbp)
    movq %rcx, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %r8
    movq -1128(%rbp), %r10
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %rdx
    movq -1152(%rbp), %rcx
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r9
    movq %rax, %rcx
    addq $32, %rcx
    movq %rcx, %r10
    movq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    addq %r10, %rcx
    movq %rcx, %rdi
    movq %r8, -1120(%rbp)
    movq %r10, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %rdx, -1144(%rbp)
    movq %rcx, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq print_int
    movq -1120(%rbp), %r8
    movq -1128(%rbp), %r10
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %rdx
    movq -1152(%rbp), %rcx
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r9
    addq $1200, %rsp
    popq %rbp
    retq 

