	.align 16
block_211:
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_212:
    movq $2, %rcx
    jmp block_211

	.align 16
block_213:
    movq $1, %rcx
    jmp block_211

	.align 16
start:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $2, %rcx
    je block_212
    jmp block_213

	.align 16
saveRegs:
    movq %rdx, -88(%rbp)
    movq %rsi, -96(%rbp)
    movq %r11, -104(%rbp)
    movq %rcx, -112(%rbp)
    movq %r10, -120(%rbp)
    movq %r8, -128(%rbp)
    movq %r9, -136(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -88(%rbp), %rdx
    movq -96(%rbp), %rsi
    movq -104(%rbp), %r11
    movq -112(%rbp), %rcx
    movq -120(%rbp), %r10
    movq -128(%rbp), %r8
    movq -136(%rbp), %r9
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    jmp start

	.align 16
conclusion:
    addq $160, %rsp
    popq %rbp
    retq 


