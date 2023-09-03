	.align 16
block_99:
    movq $0, %rax
    jmp conclusion

	.align 16
block_100:
    movq %rcx, %rdi
    movq %r9, -2120(%rbp)
    movq %rdx, -2128(%rbp)
    movq %rcx, -2136(%rbp)
    movq %r10, -2144(%rbp)
    movq %r8, -2152(%rbp)
    movq %rsi, -2160(%rbp)
    callq print_int
    movq -2120(%rbp), %r9
    movq -2128(%rbp), %rdx
    movq -2136(%rbp), %rcx
    movq -2144(%rbp), %r10
    movq -2152(%rbp), %r8
    movq -2160(%rbp), %rsi
    jmp block_99

	.align 16
block_101:
    movq $1, %rcx
    jmp block_100

	.align 16
block_102:
    movq $42, %rcx
    jmp block_100

	.align 16
block_103:
    movq %r9, -2120(%rbp)
    movq %rdx, -2128(%rbp)
    movq %rcx, -2136(%rbp)
    movq %r10, -2144(%rbp)
    movq %r8, -2152(%rbp)
    movq %rsi, -2160(%rbp)
    callq read_int
    movq -2120(%rbp), %r9
    movq -2128(%rbp), %rdx
    movq -2136(%rbp), %rcx
    movq -2144(%rbp), %r10
    movq -2152(%rbp), %r8
    movq -2160(%rbp), %rsi
    movq %rax, %rcx
    movq $42, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    movq %r9, -2120(%rbp)
    movq %rdx, -2128(%rbp)
    movq %rcx, -2136(%rbp)
    movq %r10, -2144(%rbp)
    movq %r8, -2152(%rbp)
    movq %rsi, -2160(%rbp)
    callq print_int
    movq -2120(%rbp), %r9
    movq -2128(%rbp), %rdx
    movq -2136(%rbp), %rcx
    movq -2144(%rbp), %r10
    movq -2152(%rbp), %r8
    movq -2160(%rbp), %rsi
    jmp block_99

	.align 16
block_104:
    movq %r9, -2120(%rbp)
    movq %rdx, -2128(%rbp)
    movq %rcx, -2136(%rbp)
    movq %r10, -2144(%rbp)
    movq %r8, -2152(%rbp)
    movq %rsi, -2160(%rbp)
    callq read_int
    movq -2120(%rbp), %r9
    movq -2128(%rbp), %rdx
    movq -2136(%rbp), %rcx
    movq -2144(%rbp), %r10
    movq -2152(%rbp), %r8
    movq -2160(%rbp), %rsi
    movq %rax, %rcx
    cmpq $0, %rcx
    je block_101
    jmp block_102

	.align 16
block_105:
    movq %r9, -2120(%rbp)
    movq %rdx, -2128(%rbp)
    movq %rcx, -2136(%rbp)
    movq %r10, -2144(%rbp)
    movq %r8, -2152(%rbp)
    movq %rsi, -2160(%rbp)
    callq read_int
    movq -2120(%rbp), %r9
    movq -2128(%rbp), %rdx
    movq -2136(%rbp), %rcx
    movq -2144(%rbp), %r10
    movq -2152(%rbp), %r8
    movq -2160(%rbp), %rsi
    movq %rax, %rcx
    movq %r9, -2120(%rbp)
    movq %rdx, -2128(%rbp)
    movq %rcx, -2136(%rbp)
    movq %r10, -2144(%rbp)
    movq %r8, -2152(%rbp)
    movq %rsi, -2160(%rbp)
    callq read_int
    movq -2120(%rbp), %r9
    movq -2128(%rbp), %rdx
    movq -2136(%rbp), %rcx
    movq -2144(%rbp), %r10
    movq -2152(%rbp), %r8
    movq -2160(%rbp), %rsi
    movq %rax, %rdx
    cmpq %rdx, %rcx
    jge block_103
    jmp block_104

	.align 16
start:
    movq %r9, -2120(%rbp)
    movq %rdx, -2128(%rbp)
    movq %rcx, -2136(%rbp)
    movq %r10, -2144(%rbp)
    movq %r8, -2152(%rbp)
    movq %rsi, -2160(%rbp)
    callq read_int
    movq -2120(%rbp), %r9
    movq -2128(%rbp), %rdx
    movq -2136(%rbp), %rcx
    movq -2144(%rbp), %r10
    movq -2152(%rbp), %r8
    movq -2160(%rbp), %rsi
    movq %rax, %rdx
    movq %r9, -2120(%rbp)
    movq %rdx, -2128(%rbp)
    movq %rcx, -2136(%rbp)
    movq %r10, -2144(%rbp)
    movq %r8, -2152(%rbp)
    movq %rsi, -2160(%rbp)
    callq read_int
    movq -2120(%rbp), %r9
    movq -2128(%rbp), %rdx
    movq -2136(%rbp), %rcx
    movq -2144(%rbp), %r10
    movq -2152(%rbp), %r8
    movq -2160(%rbp), %rsi
    movq %rax, %rcx
    cmpq %rcx, %rdx
    je block_105
    jmp block_104

	.align 16
conclusion:
    addq $2192, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2192, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


