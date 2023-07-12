	.align 16
block_208:
    movq $2, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_209:
    movq $4, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_208

	.align 16
start:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $0, %rcx
    sete %rdx
    cmpq $0, %rdx
    je block_208
    jmp block_209

	.align 16
saveRegs:
    movq %r8, -8(%rbp)
    movq %rdx, -16(%rbp)
    movq %rcx, -24(%rbp)
    movq %r10, -32(%rbp)
    movq %rsi, -40(%rbp)
    movq %r11, -48(%rbp)
    movq %r9, -56(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -8(%rbp), %r8
    movq -16(%rbp), %rdx
    movq -24(%rbp), %rcx
    movq -32(%rbp), %r10
    movq -40(%rbp), %rsi
    movq -48(%rbp), %r11
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


