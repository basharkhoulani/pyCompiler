	.align 16
block_236:
    movq $0, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    movq $0, %rax
    jmp conclusion

	.align 16
block_237:
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_236

	.align 16
block_238:
    movq $1, %rcx
    addq $8, %rcx
    jmp block_237

	.align 16
block_239:
    movq $4, %rcx
    jmp block_237

	.align 16
block_240:
    movq $2, %rcx
    addq $4, %rcx
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_236

	.align 16
block_241:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $3, %rcx
    je block_238
    jmp block_239

	.align 16
block_242:
    callq saveRegs
    callq read_int
    callq restoreRegs
    movq %rax, %rcx
    cmpq $2, %rcx
    je block_240
    jmp block_241

	.align 16
block_243:
    movq $2, %rcx
    addq $24, %rcx
    movq %rcx, %rdi
    callq saveRegs
    callq print_int
    callq restoreRegs
    jmp block_236

	.align 16
block_244:
    cmpq $1, %rdx
    jne block_242
    jmp block_243

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
    je block_244
    jmp block_243

	.align 16
saveRegs:
    movq %rdx, -328(%rbp)
    movq %rsi, -336(%rbp)
    movq %r11, -344(%rbp)
    movq %rcx, -352(%rbp)
    movq %r10, -360(%rbp)
    movq %r8, -368(%rbp)
    movq %r9, -376(%rbp)
    retq 

	.align 16
restoreRegs:
    movq -328(%rbp), %rdx
    movq -336(%rbp), %rsi
    movq -344(%rbp), %r11
    movq -352(%rbp), %rcx
    movq -360(%rbp), %r10
    movq -368(%rbp), %r8
    movq -376(%rbp), %r9
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $400, %rsp
    jmp start

	.align 16
conclusion:
    addq $400, %rsp
    popq %rbp
    retq 


