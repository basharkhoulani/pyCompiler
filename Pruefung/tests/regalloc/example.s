	.align 16
start:
    movq %r10, -1128(%rbp)
    movq %rsi, -1136(%rbp)
    movq %r8, -1144(%rbp)
    movq %rcx, -1152(%rbp)
    movq %rdx, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq read_int
    movq -1128(%rbp), %r10
    movq -1136(%rbp), %rsi
    movq -1144(%rbp), %r8
    movq -1152(%rbp), %rcx
    movq -1160(%rbp), %rdx
    movq -1168(%rbp), %r9
    movq %rax, %rcx
    movq %r10, -1128(%rbp)
    movq %rsi, -1136(%rbp)
    movq %r8, -1144(%rbp)
    movq %rcx, -1152(%rbp)
    movq %rdx, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq read_int
    movq -1128(%rbp), %r10
    movq -1136(%rbp), %rsi
    movq -1144(%rbp), %r8
    movq -1152(%rbp), %rcx
    movq -1160(%rbp), %rdx
    movq -1168(%rbp), %r9
    movq %rax, %rdx
    addq %rdx, %rcx
    addq $42, %rcx
    movq %rcx, %rdi
    movq %r10, -1128(%rbp)
    movq %rsi, -1136(%rbp)
    movq %r8, -1144(%rbp)
    movq %rcx, -1152(%rbp)
    movq %rdx, -1160(%rbp)
    movq %r9, -1168(%rbp)
    callq print_int
    movq -1128(%rbp), %r10
    movq -1136(%rbp), %rsi
    movq -1144(%rbp), %r8
    movq -1152(%rbp), %rcx
    movq -1160(%rbp), %rdx
    movq -1168(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1200, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1200, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


