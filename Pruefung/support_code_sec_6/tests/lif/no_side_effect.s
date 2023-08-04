	.align 16
start:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    movq $0, %rdi
    movq %r10, -2640(%rbp)
    movq %r8, -2648(%rbp)
    movq %rsi, -2656(%rbp)
    movq %rcx, -2664(%rbp)
    movq %r9, -2672(%rbp)
    movq %rdx, -2680(%rbp)
    callq print_int
    movq -2640(%rbp), %r10
    movq -2648(%rbp), %r8
    movq -2656(%rbp), %rsi
    movq -2664(%rbp), %rcx
    movq -2672(%rbp), %r9
    movq -2680(%rbp), %rdx
    movq $5, %rcx
    addq $6, %rcx
    addq $7, %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $2720, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2720, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


