	.align 16
start:
    movq $1, %rcx
    movq %rsi, -1800(%rbp)
    movq %rdx, -1808(%rbp)
    movq %r10, -1816(%rbp)
    movq %r9, -1824(%rbp)
    movq %r8, -1832(%rbp)
    movq %rcx, -1840(%rbp)
    callq read_int
    movq -1800(%rbp), %rsi
    movq -1808(%rbp), %rdx
    movq -1816(%rbp), %r10
    movq -1824(%rbp), %r9
    movq -1832(%rbp), %r8
    movq -1840(%rbp), %rcx
    movq %rax, %rsi
    movq $1, %rdx
    addq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    movq %rsi, -1800(%rbp)
    movq %rdx, -1808(%rbp)
    movq %r10, -1816(%rbp)
    movq %r9, -1824(%rbp)
    movq %r8, -1832(%rbp)
    movq %rcx, -1840(%rbp)
    callq print_int
    movq -1800(%rbp), %rsi
    movq -1808(%rbp), %rdx
    movq -1816(%rbp), %r10
    movq -1824(%rbp), %r9
    movq -1832(%rbp), %r8
    movq -1840(%rbp), %rcx
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


