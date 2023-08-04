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
    movq %r10, -2256(%rbp)
    movq %rsi, -2264(%rbp)
    movq %r8, -2272(%rbp)
    movq %rcx, -2280(%rbp)
    movq %rdx, -2288(%rbp)
    movq %r9, -2296(%rbp)
    callq print_int
    movq -2256(%rbp), %r10
    movq -2264(%rbp), %rsi
    movq -2272(%rbp), %r8
    movq -2280(%rbp), %rcx
    movq -2288(%rbp), %rdx
    movq -2296(%rbp), %r9
    jmp block_121

	.align 16
block_123:
    movq $1, %rcx
    subq $2, %rcx
    subq $3, %rcx
    movq %rcx, %rdi
    movq %r10, -2256(%rbp)
    movq %rsi, -2264(%rbp)
    movq %r8, -2272(%rbp)
    movq %rcx, -2280(%rbp)
    movq %rdx, -2288(%rbp)
    movq %r9, -2296(%rbp)
    callq print_int
    movq -2256(%rbp), %r10
    movq -2264(%rbp), %rsi
    movq -2272(%rbp), %r8
    movq -2280(%rbp), %rcx
    movq -2288(%rbp), %rdx
    movq -2296(%rbp), %r9
    jmp block_121

	.align 16
block_124:
    movq -2200(%rbp), %rax
    movq %rax, -2208(%rbp)
    movq -2216(%rbp), %rax
    addq %rax, -2208(%rbp)
    movq -2208(%rbp), %rax
    movq %rax, -2224(%rbp)
    addq %r8, -2224(%rbp)
    movq -2224(%rbp), %r8
    addq %rcx, %r8
    movq %r8, %rcx
    addq %r10, %rcx
    addq %rsi, %rcx
    addq -2232(%rbp), %rcx
    addq -2240(%rbp), %rcx
    addq -2248(%rbp), %rcx
    addq %rdx, %rcx
    addq %r9, %rcx
    movq %rcx, %rdi
    movq %r10, -2256(%rbp)
    movq %rsi, -2264(%rbp)
    movq %r8, -2272(%rbp)
    movq %rcx, -2280(%rbp)
    movq %rdx, -2288(%rbp)
    movq %r9, -2296(%rbp)
    callq print_int
    movq -2256(%rbp), %r10
    movq -2264(%rbp), %rsi
    movq -2272(%rbp), %r8
    movq -2280(%rbp), %rcx
    movq -2288(%rbp), %rdx
    movq -2296(%rbp), %r9
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
    movq $1, -2216(%rbp)
    movq $1, %r8
    movq $1, %rcx
    movq $1, %r10
    movq $1, %rsi
    movq $1, -2232(%rbp)
    movq $1, -2240(%rbp)
    movq $1, -2248(%rbp)
    movq $1, %rdx
    cmpq $1, %r9
    je block_125
    jmp block_126

	.align 16
start:
    movq %r10, -2256(%rbp)
    movq %rsi, -2264(%rbp)
    movq %r8, -2272(%rbp)
    movq %rcx, -2280(%rbp)
    movq %rdx, -2288(%rbp)
    movq %r9, -2296(%rbp)
    callq read_int
    movq -2256(%rbp), %r10
    movq -2264(%rbp), %rsi
    movq -2272(%rbp), %r8
    movq -2280(%rbp), %rcx
    movq -2288(%rbp), %rdx
    movq -2296(%rbp), %r9
    movq %rax, %r9
    movq %r10, -2256(%rbp)
    movq %rsi, -2264(%rbp)
    movq %r8, -2272(%rbp)
    movq %rcx, -2280(%rbp)
    movq %rdx, -2288(%rbp)
    movq %r9, -2296(%rbp)
    callq read_int
    movq -2256(%rbp), %r10
    movq -2264(%rbp), %rsi
    movq -2272(%rbp), %r8
    movq -2280(%rbp), %rcx
    movq -2288(%rbp), %rdx
    movq -2296(%rbp), %r9
    movq %rax, %rcx
    cmpq $0, %r9
    je block_127
    jmp block_128

	.align 16
conclusion:
    addq $2336, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2336, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


