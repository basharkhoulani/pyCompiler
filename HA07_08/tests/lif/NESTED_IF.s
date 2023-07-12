	.align 16
block_249:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_250:
    movq %rdx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_249

	.align 16
block_251:
    movq $4, %rcx
    addq $4, %rcx
    movq %rcx, %rdx
    jmp block_250

	.align 16
block_252:
    movq $1, %rcx
    addq $8, %rcx
    movq %rcx, %rdx
    jmp block_250

	.align 16
block_253:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $2, %rcx
    je block_251
    jmp block_252

	.align 16
block_254:
    movq $24, %rcx
    addq $24, %rcx
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_249

	.align 16
block_255:
    cmpq $1, %rcx
    jne block_253
    jmp block_254

	.align 16
start:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rdx
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $0, %rdx
    je block_255
    jmp block_254

	.align 16
saveRegs:
    movq %rcx, -488(%rbp)
    movq %rdx, -496(%rbp)
    movq %r11, -504(%rbp)
    movq %r9, -512(%rbp)
    movq %r10, -520(%rbp)
    movq %rsi, -528(%rbp)
    movq %r8, -536(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -488(%rbp), %rcx
    movq -496(%rbp), %rdx
    movq -504(%rbp), %r11
    movq -512(%rbp), %r9
    movq -520(%rbp), %r10
    movq -528(%rbp), %rsi
    movq -536(%rbp), %r8
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $560, %rsp
    jmp start

	.align 16
conclusion:
    addq $560, %rsp
    popq %rbp
    retq 


