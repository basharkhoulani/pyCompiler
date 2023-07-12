	.align 16
block_221:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_222:
    movq %rdx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_221

	.align 16
block_223:
    movq $4, %rcx
    addq $4, %rcx
    movq %rcx, %rdx
    jmp block_222

	.align 16
block_224:
    movq $1, %rcx
    addq $8, %rcx
    movq %rcx, %rdx
    jmp block_222

	.align 16
block_225:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $2, %rcx
    je block_223
    jmp block_224

	.align 16
block_226:
    movq $24, %rcx
    addq $24, %rcx
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_221

	.align 16
block_227:
    cmpq $1, %rcx
    jne block_225
    jmp block_226

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
    je block_227
    jmp block_226

	.align 16
saveRegs:
    movq %rdx, -248(%rbp)
    movq %rsi, -256(%rbp)
    movq %r11, -264(%rbp)
    movq %rcx, -272(%rbp)
    movq %r10, -280(%rbp)
    movq %r8, -288(%rbp)
    movq %r9, -296(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -248(%rbp), %rdx
    movq -256(%rbp), %rsi
    movq -264(%rbp), %r11
    movq -272(%rbp), %rcx
    movq -280(%rbp), %r10
    movq -288(%rbp), %r8
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


