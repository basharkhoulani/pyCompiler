	.align 16
block_131:
    movq $0, %rax
    jmp conclusion

	.align 16
block_132:
    movq $0, %rdi
    movq %r10, -2400(%rbp)
    movq %r8, -2408(%rbp)
    movq %rsi, -2416(%rbp)
    movq %rcx, -2424(%rbp)
    movq %r9, -2432(%rbp)
    movq %rdx, -2440(%rbp)
    callq print_int
    movq -2400(%rbp), %r10
    movq -2408(%rbp), %r8
    movq -2416(%rbp), %rsi
    movq -2424(%rbp), %rcx
    movq -2432(%rbp), %r9
    movq -2440(%rbp), %rdx
    jmp block_131

	.align 16
block_133:
    movq $1, %rdi
    movq %r10, -2400(%rbp)
    movq %r8, -2408(%rbp)
    movq %rsi, -2416(%rbp)
    movq %rcx, -2424(%rbp)
    movq %r9, -2432(%rbp)
    movq %rdx, -2440(%rbp)
    callq print_int
    movq -2400(%rbp), %r10
    movq -2408(%rbp), %r8
    movq -2416(%rbp), %rsi
    movq -2424(%rbp), %rcx
    movq -2432(%rbp), %r9
    movq -2440(%rbp), %rdx
    jmp block_131

	.align 16
start:
    jmp block_133

	.align 16
conclusion:
    addq $2480, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2480, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


