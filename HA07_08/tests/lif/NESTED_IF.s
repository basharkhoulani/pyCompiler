	.align 16
block_242:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_243:
    movq %rdx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_242

	.align 16
block_244:
    movq $4, %rcx
    addq $4, %rcx
    movq %rcx, %rdx
    jmp block_243

	.align 16
block_245:
    movq $1, %rcx
    addq $8, %rcx
    movq %rcx, %rdx
    jmp block_243

	.align 16
block_246:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $2, %rcx
    je block_244
    jmp block_245

	.align 16
block_247:
    movq $24, %rcx
    addq $24, %rcx
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_242

	.align 16
block_248:
    cmpq $1, %rcx
    jne block_246
    jmp block_247

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
    je block_248
    jmp block_247

	.align 16
saveRegs:
    movq %rdx, -408(%rbp)
    movq %r8, -416(%rbp)
    movq %r11, -424(%rbp)
    movq %rsi, -432(%rbp)
    movq %r10, -440(%rbp)
    movq %rcx, -448(%rbp)
    movq %r9, -456(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -408(%rbp), %rdx
    movq -416(%rbp), %r8
    movq -424(%rbp), %r11
    movq -432(%rbp), %rsi
    movq -440(%rbp), %r10
    movq -448(%rbp), %rcx
    movq -456(%rbp), %r9
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


