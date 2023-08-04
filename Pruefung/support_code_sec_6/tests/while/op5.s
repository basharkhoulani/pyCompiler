	.align 16
block_169:
    movq %rcx, %rdi
    movq %r10, -2880(%rbp)
    movq %r8, -2888(%rbp)
    movq %rsi, -2896(%rbp)
    movq %rcx, -2904(%rbp)
    movq %r9, -2912(%rbp)
    movq %rdx, -2920(%rbp)
    callq print_int
    movq -2880(%rbp), %r10
    movq -2888(%rbp), %r8
    movq -2896(%rbp), %rsi
    movq -2904(%rbp), %rcx
    movq -2912(%rbp), %r9
    movq -2920(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_171:
    subq $1, %rcx
    jmp loop_170

	.align 16
loop_170:
    cmpq $0, %rcx
    jne block_171
    jmp block_169

	.align 16
start:
    movq $10, %rcx
    jmp loop_170

	.align 16
conclusion:
    addq $2960, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2960, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


