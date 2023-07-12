	.align 16
block_244:
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_245:
    movq $2, %rcx
    jmp block_244

	.align 16
block_246:
    movq $1, %rcx
    jmp block_244

	.align 16
start:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $2, %rcx
    je block_245
    jmp block_246

	.align 16
saveRegs:
    movq %rcx, -408(%rbp)
    movq %rdx, -416(%rbp)
    movq %r11, -424(%rbp)
    movq %r9, -432(%rbp)
    movq %r10, -440(%rbp)
    movq %rsi, -448(%rbp)
    movq %r8, -456(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -408(%rbp), %rcx
    movq -416(%rbp), %rdx
    movq -424(%rbp), %r11
    movq -432(%rbp), %r9
    movq -440(%rbp), %r10
    movq -448(%rbp), %rsi
    movq -456(%rbp), %r8
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $480, %rsp
    jmp start

	.align 16
conclusion:
    addq $480, %rsp
    popq %rbp
    retq 


