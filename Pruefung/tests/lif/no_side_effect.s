	.align 16
start:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    movq $0, %rdi
    movq %r10, -2416(%rbp)
    movq %rsi, -2424(%rbp)
    movq %r8, -2432(%rbp)
    movq %rcx, -2440(%rbp)
    movq %rdx, -2448(%rbp)
    movq %r9, -2456(%rbp)
    callq print_int
    movq -2416(%rbp), %r10
    movq -2424(%rbp), %rsi
    movq -2432(%rbp), %r8
    movq -2440(%rbp), %rcx
    movq -2448(%rbp), %rdx
    movq -2456(%rbp), %r9
    movq $5, %rcx
    addq $6, %rcx
    addq $7, %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $2496, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2496, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


