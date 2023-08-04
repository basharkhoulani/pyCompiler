	.align 16
block_228:
    movq %rcx, %rdi
    movq %r10, -3920(%rbp)
    movq %r8, -3928(%rbp)
    movq %rsi, -3936(%rbp)
    movq %rcx, -3944(%rbp)
    movq %r9, -3952(%rbp)
    movq %rdx, -3960(%rbp)
    callq print_int
    movq -3920(%rbp), %r10
    movq -3928(%rbp), %r8
    movq -3936(%rbp), %rsi
    movq -3944(%rbp), %rcx
    movq -3952(%rbp), %r9
    movq -3960(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_230:
    addq $1, %rcx
    jmp loop_229

	.align 16
loop_229:
    cmpq $10, %rcx
    jle block_230
    jmp block_228

	.align 16
start:
    movq $0, %rcx
    jmp loop_229

	.align 16
conclusion:
    addq $4000, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4000, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


