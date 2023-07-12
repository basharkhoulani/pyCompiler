	.align 16
block_231:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_232:
    movq $1, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_231

	.align 16
block_233:
    movq $2, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_231

	.align 16
block_234:
    cmpq $1, %rdx
    jne block_232
    jmp block_233

	.align 16
block_235:
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
start:
    movq $0, %rcx
    jmp block_235

	.align 16
saveRegs:
    movq %rdx, -248(%rbp)
    movq %r8, -256(%rbp)
    movq %r11, -264(%rbp)
    movq %rsi, -272(%rbp)
    movq %r10, -280(%rbp)
    movq %rcx, -288(%rbp)
    movq %r9, -296(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -248(%rbp), %rdx
    movq -256(%rbp), %r8
    movq -264(%rbp), %r11
    movq -272(%rbp), %rsi
    movq -280(%rbp), %r10
    movq -288(%rbp), %rcx
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


