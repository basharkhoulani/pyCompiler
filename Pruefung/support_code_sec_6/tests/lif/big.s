	.align 16
block_103:
    movq $0, %rax
    jmp conclusion

	.align 16
block_104:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    subq $4, %rcx
    movq %rcx, %rdi
    movq %r10, -2080(%rbp)
    movq %r8, -2088(%rbp)
    movq %rsi, -2096(%rbp)
    movq %rcx, -2104(%rbp)
    movq %r9, -2112(%rbp)
    movq %rdx, -2120(%rbp)
    callq print_int
    movq -2080(%rbp), %r10
    movq -2088(%rbp), %r8
    movq -2096(%rbp), %rsi
    movq -2104(%rbp), %rcx
    movq -2112(%rbp), %r9
    movq -2120(%rbp), %rdx
    jmp block_103

	.align 16
block_105:
    movq $1, %rcx
    subq $2, %rcx
    subq $3, %rcx
    movq %rcx, %rdi
    movq %r10, -2080(%rbp)
    movq %r8, -2088(%rbp)
    movq %rsi, -2096(%rbp)
    movq %rcx, -2104(%rbp)
    movq %r9, -2112(%rbp)
    movq %rdx, -2120(%rbp)
    callq print_int
    movq -2080(%rbp), %r10
    movq -2088(%rbp), %r8
    movq -2096(%rbp), %rsi
    movq -2104(%rbp), %rcx
    movq -2112(%rbp), %r9
    movq -2120(%rbp), %rdx
    jmp block_103

	.align 16
block_106:
    addq %rcx, %rsi
    movq %rsi, %rcx
    addq -2040(%rbp), %rcx
    addq -2048(%rbp), %rcx
    addq -2056(%rbp), %rcx
    addq %r8, %rcx
    addq -2064(%rbp), %rcx
    addq -2072(%rbp), %rcx
    addq %r10, %rcx
    addq %rdx, %rcx
    addq %r9, %rcx
    movq %rcx, %rdi
    movq %r10, -2080(%rbp)
    movq %r8, -2088(%rbp)
    movq %rsi, -2096(%rbp)
    movq %rcx, -2104(%rbp)
    movq %r9, -2112(%rbp)
    movq %rdx, -2120(%rbp)
    callq print_int
    movq -2080(%rbp), %r10
    movq -2088(%rbp), %r8
    movq -2096(%rbp), %rsi
    movq -2104(%rbp), %rcx
    movq -2112(%rbp), %r9
    movq -2120(%rbp), %rdx
    jmp block_103

	.align 16
block_107:
    movq $10, %r9
    negq %r9
    jmp block_106

	.align 16
block_108:
    movq $10, %r9
    jmp block_106

	.align 16
block_109:
    cmpq $1, %rcx
    je block_104
    jmp block_105

	.align 16
block_110:
    movq $1, %rsi
    movq $1, %rcx
    movq $1, -2040(%rbp)
    movq $1, -2048(%rbp)
    movq $1, -2056(%rbp)
    movq $1, %r8
    movq $1, -2064(%rbp)
    movq $1, -2072(%rbp)
    movq $1, %r10
    movq $1, %rdx
    cmpq $1, %r9
    je block_107
    jmp block_108

	.align 16
start:
    movq %r10, -2080(%rbp)
    movq %r8, -2088(%rbp)
    movq %rsi, -2096(%rbp)
    movq %rcx, -2104(%rbp)
    movq %r9, -2112(%rbp)
    movq %rdx, -2120(%rbp)
    callq read_int
    movq -2080(%rbp), %r10
    movq -2088(%rbp), %r8
    movq -2096(%rbp), %rsi
    movq -2104(%rbp), %rcx
    movq -2112(%rbp), %r9
    movq -2120(%rbp), %rdx
    movq %rax, %r9
    movq %r10, -2080(%rbp)
    movq %r8, -2088(%rbp)
    movq %rsi, -2096(%rbp)
    movq %rcx, -2104(%rbp)
    movq %r9, -2112(%rbp)
    movq %rdx, -2120(%rbp)
    callq read_int
    movq -2080(%rbp), %r10
    movq -2088(%rbp), %r8
    movq -2096(%rbp), %rsi
    movq -2104(%rbp), %rcx
    movq -2112(%rbp), %r9
    movq -2120(%rbp), %rdx
    movq %rax, %rcx
    cmpq $0, %r9
    je block_109
    jmp block_110

	.align 16
conclusion:
    addq $2160, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2160, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


