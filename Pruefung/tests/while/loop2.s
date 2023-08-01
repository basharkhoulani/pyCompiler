	.align 16
block_169:
    movq $1, %rdi
    movq %rsi, -2888(%rbp)
    movq %rdx, -2896(%rbp)
    movq %r10, -2904(%rbp)
    movq %r9, -2912(%rbp)
    movq %r8, -2920(%rbp)
    movq %rcx, -2928(%rbp)
    callq print_int
    movq -2888(%rbp), %rsi
    movq -2896(%rbp), %rdx
    movq -2904(%rbp), %r10
    movq -2912(%rbp), %r9
    movq -2920(%rbp), %r8
    movq -2928(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
block_171:
    movq $0, %rdi
    movq %rsi, -2888(%rbp)
    movq %rdx, -2896(%rbp)
    movq %r10, -2904(%rbp)
    movq %r9, -2912(%rbp)
    movq %r8, -2920(%rbp)
    movq %rcx, -2928(%rbp)
    callq print_int
    movq -2888(%rbp), %rsi
    movq -2896(%rbp), %rdx
    movq -2904(%rbp), %r10
    movq -2912(%rbp), %r9
    movq -2920(%rbp), %r8
    movq -2928(%rbp), %rcx
    jmp loop_170

	.align 16
loop_170:
    movq $1, %rax
    cmpq $2, %rax
    je block_171
    jmp block_169

	.align 16
loop_172:
    jmp loop_170

	.align 16
start:
    jmp loop_172

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


