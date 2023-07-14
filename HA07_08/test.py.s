	.align 16
block_2:
    movq $1, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_3:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $5, %rcx
    setl %rdx
    cmpq $0, %rdx
    je block_4
    jmp block_2

	.align 16
block_4:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_3

	.align 16
start:
    jmp block_3

	.align 16
saveRegs:
    movq %rdx, -8(%rbp)
    movq %r8, -16(%rbp)
    movq %r11, -24(%rbp)
    movq %rsi, -32(%rbp)
    movq %r10, -40(%rbp)
    movq %rcx, -48(%rbp)
    movq %r9, -56(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -8(%rbp), %rdx
    movq -16(%rbp), %r8
    movq -24(%rbp), %r11
    movq -32(%rbp), %rsi
    movq -40(%rbp), %r10
    movq -48(%rbp), %rcx
    movq -56(%rbp), %r9
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    jmp start

	.align 16
conclusion:
    addq $80, %rsp
    popq %rbp
    retq 


