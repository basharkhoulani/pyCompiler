	.align 16
block_218:
    movq $1, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_219:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $3, %rcx
    jl block_220
    jmp block_218

	.align 16
block_220:
    movq $9, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_219

	.align 16
start:
    jmp block_219

	.align 16
saveRegs:
    movq %rcx, -168(%rbp)
    movq %rdx, -176(%rbp)
    movq %r11, -184(%rbp)
    movq %r9, -192(%rbp)
    movq %r10, -200(%rbp)
    movq %rsi, -208(%rbp)
    movq %r8, -216(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -168(%rbp), %rcx
    movq -176(%rbp), %rdx
    movq -184(%rbp), %r11
    movq -192(%rbp), %r9
    movq -200(%rbp), %r10
    movq -208(%rbp), %rsi
    movq -216(%rbp), %r8
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


