	.align 16
block_226:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_227:
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_226

	.align 16
block_228:
    movq $1, %rcx
    addq $8, %rcx
    jmp block_227

	.align 16
block_229:
    movq $4, %rcx
    jmp block_227

	.align 16
block_230:
    movq $2, %rcx
    addq $4, %rcx
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_226

	.align 16
block_231:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $3, %rcx
    je block_228
    jmp block_229

	.align 16
block_232:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $2, %rcx
    je block_230
    jmp block_231

	.align 16
block_233:
    movq $2, %rcx
    addq $24, %rcx
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_226

	.align 16
block_234:
    cmpq $1, %rdx
    jne block_232
    jmp block_233

	.align 16
start:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rdx
    cmpq $0, %rcx
    je block_234
    jmp block_233

	.align 16
saveRegs:
    movq %r8, -248(%rbp)
    movq %r10, -256(%rbp)
    movq %r11, -264(%rbp)
    movq %rdx, -272(%rbp)
    movq %rcx, -280(%rbp)
    movq %rsi, -288(%rbp)
    movq %r9, -296(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -248(%rbp), %r8
    movq -256(%rbp), %r10
    movq -264(%rbp), %r11
    movq -272(%rbp), %rdx
    movq -280(%rbp), %rcx
    movq -288(%rbp), %rsi
    movq -296(%rbp), %r9
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    jmp start

	.align 16
conclusion:
    addq $320, %rsp
    popq %rbp
    retq 


