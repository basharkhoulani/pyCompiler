	.align 16
block_211:
    movq $1, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_212:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $3, %rcx
    jl block_215
    jmp block_211

	.align 16
block_213:
    cmpq $3, %rcx
    jl block_214
    jmp block_212

	.align 16
block_214:
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    addq $1, %rcx
    jmp block_213

	.align 16
block_215:
    movq $1, %rcx
    jmp block_213

	.align 16
start:
    jmp block_212

	.align 16
saveRegs:
    movq %r8, -88(%rbp)
    movq %r10, -96(%rbp)
    movq %r11, -104(%rbp)
    movq %rdx, -112(%rbp)
    movq %rcx, -120(%rbp)
    movq %rsi, -128(%rbp)
    movq %r9, -136(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -88(%rbp), %r8
    movq -96(%rbp), %r10
    movq -104(%rbp), %r11
    movq -112(%rbp), %rdx
    movq -120(%rbp), %rcx
    movq -128(%rbp), %rsi
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


