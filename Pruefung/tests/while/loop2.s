	.align 16
block_169:
    movq $1, %rdi
    movq %r10, -2896(%rbp)
    movq %rsi, -2904(%rbp)
    movq %r8, -2912(%rbp)
    movq %rcx, -2920(%rbp)
    movq %rdx, -2928(%rbp)
    movq %r9, -2936(%rbp)
    callq print_int
    movq -2896(%rbp), %r10
    movq -2904(%rbp), %rsi
    movq -2912(%rbp), %r8
    movq -2920(%rbp), %rcx
    movq -2928(%rbp), %rdx
    movq -2936(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
block_171:
    movq $0, %rdi
    movq %r10, -2896(%rbp)
    movq %rsi, -2904(%rbp)
    movq %r8, -2912(%rbp)
    movq %rcx, -2920(%rbp)
    movq %rdx, -2928(%rbp)
    movq %r9, -2936(%rbp)
    callq print_int
    movq -2896(%rbp), %r10
    movq -2904(%rbp), %rsi
    movq -2912(%rbp), %r8
    movq -2920(%rbp), %rcx
    movq -2928(%rbp), %rdx
    movq -2936(%rbp), %r9
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
    addq $2976, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2976, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


