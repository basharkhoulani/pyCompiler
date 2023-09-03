	.align 16
start:
    movq %r9, -1128(%rbp)
    movq %rdx, -1136(%rbp)
    movq %rcx, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %r8, -1160(%rbp)
    movq %rsi, -1168(%rbp)
    callq read_int
    movq -1128(%rbp), %r9
    movq -1136(%rbp), %rdx
    movq -1144(%rbp), %rcx
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %r8
    movq -1168(%rbp), %rsi
    movq %rax, %rcx
    movq %r9, -1128(%rbp)
    movq %rdx, -1136(%rbp)
    movq %rcx, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %r8, -1160(%rbp)
    movq %rsi, -1168(%rbp)
    callq read_int
    movq -1128(%rbp), %r9
    movq -1136(%rbp), %rdx
    movq -1144(%rbp), %rcx
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %r8
    movq -1168(%rbp), %rsi
    movq %rax, %rdx
    addq %rdx, %rcx
    addq $42, %rcx
    movq %rcx, %rdi
    movq %r9, -1128(%rbp)
    movq %rdx, -1136(%rbp)
    movq %rcx, -1144(%rbp)
    movq %r10, -1152(%rbp)
    movq %r8, -1160(%rbp)
    movq %rsi, -1168(%rbp)
    callq print_int
    movq -1128(%rbp), %r9
    movq -1136(%rbp), %rdx
    movq -1144(%rbp), %rcx
    movq -1152(%rbp), %r10
    movq -1160(%rbp), %r8
    movq -1168(%rbp), %rsi
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


