	.align 16
block_121:
    movq $0, %rax
    jmp conclusion

	.align 16
block_122:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    subq $4, %rcx
    movq %rcx, %rdi
    movq %rsi, -2248(%rbp)
    movq %rdx, -2256(%rbp)
    movq %r10, -2264(%rbp)
    movq %r9, -2272(%rbp)
    movq %r8, -2280(%rbp)
    movq %rcx, -2288(%rbp)
    callq print_int
    movq -2248(%rbp), %rsi
    movq -2256(%rbp), %rdx
    movq -2264(%rbp), %r10
    movq -2272(%rbp), %r9
    movq -2280(%rbp), %r8
    movq -2288(%rbp), %rcx
    jmp block_121

	.align 16
block_123:
    movq $1, %rcx
    subq $2, %rcx
    subq $3, %rcx
    movq %rcx, %rdi
    movq %rsi, -2248(%rbp)
    movq %rdx, -2256(%rbp)
    movq %r10, -2264(%rbp)
    movq %r9, -2272(%rbp)
    movq %r8, -2280(%rbp)
    movq %rcx, -2288(%rbp)
    callq print_int
    movq -2248(%rbp), %rsi
    movq -2256(%rbp), %rdx
    movq -2264(%rbp), %r10
    movq -2272(%rbp), %r9
    movq -2280(%rbp), %r8
    movq -2288(%rbp), %rcx
    jmp block_121

	.align 16
block_124:
    movq -2200(%rbp), %rax
    movq %rax, -2208(%rbp)
    addq %rdx, -2208(%rbp)
    movq -2208(%rbp), %rdx
    addq -2216(%rbp), %rdx
    addq %rsi, %rdx
    addq -2224(%rbp), %rdx
    addq %r10, %rdx
    addq %rcx, %rdx
    movq %rdx, %rcx
    addq %r8, %rcx
    addq -2232(%rbp), %rcx
    addq -2240(%rbp), %rcx
    addq %r9, %rcx
    movq %rcx, %rdi
    movq %rsi, -2248(%rbp)
    movq %rdx, -2256(%rbp)
    movq %r10, -2264(%rbp)
    movq %r9, -2272(%rbp)
    movq %r8, -2280(%rbp)
    movq %rcx, -2288(%rbp)
    callq print_int
    movq -2248(%rbp), %rsi
    movq -2256(%rbp), %rdx
    movq -2264(%rbp), %r10
    movq -2272(%rbp), %r9
    movq -2280(%rbp), %r8
    movq -2288(%rbp), %rcx
    jmp block_121

	.align 16
block_125:
    movq $10, %r9
    negq %r9
    jmp block_124

	.align 16
block_126:
    movq $10, %r9
    jmp block_124

	.align 16
block_127:
    cmpq $1, %rcx
    je block_122
    jmp block_123

	.align 16
block_128:
    movq $1, -2200(%rbp)
    movq $1, %rdx
    movq $1, -2216(%rbp)
    movq $1, %rsi
    movq $1, -2224(%rbp)
    movq $1, %r10
    movq $1, %rcx
    movq $1, %r8
    movq $1, -2232(%rbp)
    movq $1, -2240(%rbp)
    cmpq $1, %r9
    je block_125
    jmp block_126

	.align 16
start:
    movq %rsi, -2248(%rbp)
    movq %rdx, -2256(%rbp)
    movq %r10, -2264(%rbp)
    movq %r9, -2272(%rbp)
    movq %r8, -2280(%rbp)
    movq %rcx, -2288(%rbp)
    callq read_int
    movq -2248(%rbp), %rsi
    movq -2256(%rbp), %rdx
    movq -2264(%rbp), %r10
    movq -2272(%rbp), %r9
    movq -2280(%rbp), %r8
    movq -2288(%rbp), %rcx
    movq %rax, %r9
    movq %rsi, -2248(%rbp)
    movq %rdx, -2256(%rbp)
    movq %r10, -2264(%rbp)
    movq %r9, -2272(%rbp)
    movq %r8, -2280(%rbp)
    movq %rcx, -2288(%rbp)
    callq read_int
    movq -2248(%rbp), %rsi
    movq -2256(%rbp), %rdx
    movq -2264(%rbp), %r10
    movq -2272(%rbp), %r9
    movq -2280(%rbp), %r8
    movq -2288(%rbp), %rcx
    movq %rax, %rcx
    cmpq $0, %r9
    je block_127
    jmp block_128

	.align 16
conclusion:
    addq $2320, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2320, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


