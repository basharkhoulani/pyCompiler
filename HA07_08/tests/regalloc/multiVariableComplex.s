	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1200, %rsp
    movq %rcx, -1120(%rbp)
    movq %rdx, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %r9, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r8, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %rcx
    movq -1128(%rbp), %rdx
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %r9
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r8
    movq %rax, %rcx
    addq $2, %rcx
    movq %rcx, %rdx
    movq %rcx, -1120(%rbp)
    movq %rdx, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %r9, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r8, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %rcx
    movq -1128(%rbp), %rdx
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %r9
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r8
    movq %rax, %rcx
    addq $4, %rcx
    movq %rcx, %rsi
    movq %rcx, -1120(%rbp)
    movq %rdx, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %r9, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r8, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %rcx
    movq -1128(%rbp), %rdx
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %r9
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r8
    movq %rax, %rcx
    addq $8, %rcx
    movq %rcx, %r8
    movq %rcx, -1120(%rbp)
    movq %rdx, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %r9, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r8, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %rcx
    movq -1128(%rbp), %rdx
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %r9
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r8
    movq %rax, %rcx
    addq $16, %rcx
    movq %rcx, %r9
    movq %rcx, -1120(%rbp)
    movq %rdx, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %r9, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r8, -1168(%rbp)
    callq read_int
    movq -1120(%rbp), %rcx
    movq -1128(%rbp), %rdx
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %r9
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r8
    movq %rax, %rcx
    addq $32, %rcx
    movq %rcx, %r10
    movq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    addq %r10, %rcx
    movq %rcx, %rdi
    movq %rcx, -1120(%rbp)
    movq %rdx, -1128(%rbp)
    movq %r11, -1136(%rbp)
    movq %r9, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %rsi, -1160(%rbp)
    movq %r8, -1168(%rbp)
    callq print_int
    movq -1120(%rbp), %rcx
    movq -1128(%rbp), %rdx
    movq -1136(%rbp), %r11
    movq -1144(%rbp), %r9
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %rsi
    movq -1168(%rbp), %r8
    addq $1200, %rsp
    popq %rbp
    retq 

