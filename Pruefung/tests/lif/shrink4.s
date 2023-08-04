	.align 16
block_153:
    movq %rcx, %rdi
    movq %r10, -2656(%rbp)
    movq %rsi, -2664(%rbp)
    movq %r8, -2672(%rbp)
    movq %rcx, -2680(%rbp)
    movq %rdx, -2688(%rbp)
    movq %r9, -2696(%rbp)
    callq print_int
    movq -2656(%rbp), %r10
    movq -2664(%rbp), %rsi
    movq -2672(%rbp), %r8
    movq -2680(%rbp), %rcx
    movq -2688(%rbp), %rdx
    movq -2696(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
start:
    movq $1, %rcx
    jmp block_153

	.align 16
conclusion:
    addq $2736, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2736, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


