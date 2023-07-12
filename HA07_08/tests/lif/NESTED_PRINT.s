	.align 16
block_219:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_220:
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_219

	.align 16
block_221:
    movq $1, %rcx
    addq $8, %rcx
    jmp block_220

	.align 16
block_222:
    movq $4, %rcx
    jmp block_220

	.align 16
block_223:
    movq $2, %rcx
    addq $4, %rcx
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_219

	.align 16
block_224:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $3, %rcx
    je block_221
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
    movq $2, %rcx
    addq $24, %rcx
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_219

	.align 16
block_227:
    cmpq $1, %rdx
    jne block_225
    jmp block_226

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
    je block_227
    jmp block_226

	.align 16
saveRegs:
    movq %rdx, -168(%rbp)
    movq %r8, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %rsi, -192(%rbp)
    movq %r10, -200(%rbp)
    movq %rcx, -208(%rbp)
    movq %r9, -216(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -168(%rbp), %rdx
    movq -176(%rbp), %r8
    movq -184(%rbp), %r11
    movq -192(%rbp), %rsi
    movq -200(%rbp), %r10
    movq -208(%rbp), %rcx
    movq -216(%rbp), %r9
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $240, %rsp
    jmp start

	.align 16
conclusion:
    addq $240, %rsp
    popq %rbp
    retq 


