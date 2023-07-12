	.align 16
block_214:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_215:
    movq $1, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_214

	.align 16
block_216:
    movq $2, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_214

	.align 16
block_217:
    cmpq $1, %rdx
    jne block_215
    jmp block_216

	.align 16
block_218:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rdx
    cmpq $0, %rcx
    je block_217
    jmp block_216

	.align 16
start:
    movq $0, %rcx
    jmp block_218

	.align 16
saveRegs:
    movq %rdx, -168(%rbp)
    movq %rsi, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %rcx, -192(%rbp)
    movq %r10, -200(%rbp)
    movq %r8, -208(%rbp)
    movq %r9, -216(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -168(%rbp), %rdx
    movq -176(%rbp), %rsi
    movq -184(%rbp), %r11
    movq -192(%rbp), %rcx
    movq -200(%rbp), %r10
    movq -208(%rbp), %r8
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


