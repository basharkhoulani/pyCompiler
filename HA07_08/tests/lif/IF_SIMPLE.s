	.align 16
block_238:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_239:
    movq $1, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_238

	.align 16
block_240:
    movq $2, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_238

	.align 16
block_241:
    cmpq $1, %rdx
    jne block_239
    jmp block_240

	.align 16
block_242:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rdx
    cmpq $0, %rcx
    je block_241
    jmp block_240

	.align 16
start:
    movq $0, %rcx
    jmp block_242

	.align 16
saveRegs:
    movq %rcx, -328(%rbp)
    movq %rdx, -336(%rbp)
    movq %r11, -344(%rbp)
    movq %r9, -352(%rbp)
    movq %r10, -360(%rbp)
    movq %rsi, -368(%rbp)
    movq %r8, -376(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -328(%rbp), %rcx
    movq -336(%rbp), %rdx
    movq -344(%rbp), %r11
    movq -352(%rbp), %r9
    movq -360(%rbp), %r10
    movq -368(%rbp), %rsi
    movq -376(%rbp), %r8
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $400, %rsp
    jmp start

	.align 16
conclusion:
    addq $400, %rsp
    popq %rbp
    retq 


