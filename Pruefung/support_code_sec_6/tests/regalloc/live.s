	.align 16
start:
    movq $1, %rdx
    movq $0, %rcx
    movq %rdx, %rdi
    movq %r10, -1720(%rbp)
    movq %r8, -1728(%rbp)
    movq %rsi, -1736(%rbp)
    movq %rcx, -1744(%rbp)
    movq %r9, -1752(%rbp)
    movq %rdx, -1760(%rbp)
    callq print_int
    movq -1720(%rbp), %r10
    movq -1728(%rbp), %r8
    movq -1736(%rbp), %rsi
    movq -1744(%rbp), %rcx
    movq -1752(%rbp), %r9
    movq -1760(%rbp), %rdx
    movq %rcx, %rdi
    movq %r10, -1720(%rbp)
    movq %r8, -1728(%rbp)
    movq %rsi, -1736(%rbp)
    movq %rcx, -1744(%rbp)
    movq %r9, -1752(%rbp)
    movq %rdx, -1760(%rbp)
    callq print_int
    movq -1720(%rbp), %r10
    movq -1728(%rbp), %r8
    movq -1736(%rbp), %rsi
    movq -1744(%rbp), %rcx
    movq -1752(%rbp), %r9
    movq -1760(%rbp), %rdx
    movq $2, %rcx
    addq %rcx, %rdx
    movq %rdx, %rdi
    movq %r10, -1720(%rbp)
    movq %r8, -1728(%rbp)
    movq %rsi, -1736(%rbp)
    movq %rcx, -1744(%rbp)
    movq %r9, -1752(%rbp)
    movq %rdx, -1760(%rbp)
    callq print_int
    movq -1720(%rbp), %r10
    movq -1728(%rbp), %r8
    movq -1736(%rbp), %rsi
    movq -1744(%rbp), %rcx
    movq -1752(%rbp), %r9
    movq -1760(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1792, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1792, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


