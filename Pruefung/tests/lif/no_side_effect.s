	.align 16
start:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    movq $0, %rdi
    movq %rsi, -2408(%rbp)
    movq %rdx, -2416(%rbp)
    movq %r10, -2424(%rbp)
    movq %r9, -2432(%rbp)
    movq %r8, -2440(%rbp)
    movq %rcx, -2448(%rbp)
    callq print_int
    movq -2408(%rbp), %rsi
    movq -2416(%rbp), %rdx
    movq -2424(%rbp), %r10
    movq -2432(%rbp), %r9
    movq -2440(%rbp), %r8
    movq -2448(%rbp), %rcx
    movq $5, %rcx
    addq $6, %rcx
    addq $7, %rcx
    movq $0, %rax
    jmp conclusion

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


