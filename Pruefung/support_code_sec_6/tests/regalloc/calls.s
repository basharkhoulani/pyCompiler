	.align 16
start:
    movq $1, %rcx
    movq %r10, -1800(%rbp)
    movq %r8, -1808(%rbp)
    movq %rsi, -1816(%rbp)
    movq %rcx, -1824(%rbp)
    movq %r9, -1832(%rbp)
    movq %rdx, -1840(%rbp)
    callq read_int
    movq -1800(%rbp), %r10
    movq -1808(%rbp), %r8
    movq -1816(%rbp), %rsi
    movq -1824(%rbp), %rcx
    movq -1832(%rbp), %r9
    movq -1840(%rbp), %rdx
    movq %rax, %rsi
    movq $1, %rdx
    addq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    movq %r10, -1800(%rbp)
    movq %r8, -1808(%rbp)
    movq %rsi, -1816(%rbp)
    movq %rcx, -1824(%rbp)
    movq %r9, -1832(%rbp)
    movq %rdx, -1840(%rbp)
    callq print_int
    movq -1800(%rbp), %r10
    movq -1808(%rbp), %r8
    movq -1816(%rbp), %rsi
    movq -1824(%rbp), %rcx
    movq -1832(%rbp), %r9
    movq -1840(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1872, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1872, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


