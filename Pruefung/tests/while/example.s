	.align 16
block_187:
    movq %rdx, %rdi
    movq %r10, -3296(%rbp)
    movq %rsi, -3304(%rbp)
    movq %r8, -3312(%rbp)
    movq %rcx, -3320(%rbp)
    movq %rdx, -3328(%rbp)
    movq %r9, -3336(%rbp)
    callq print_int
    movq -3296(%rbp), %r10
    movq -3304(%rbp), %rsi
    movq -3312(%rbp), %r8
    movq -3320(%rbp), %rcx
    movq -3328(%rbp), %rdx
    movq -3336(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
block_189:
    addq %rcx, %rdx
    subq $1, %rcx
    jmp loop_188

	.align 16
loop_188:
    cmpq $0, %rcx
    jg block_189
    jmp block_187

	.align 16
start:
    movq $0, %rdx
    movq $5, %rcx
    jmp loop_188

	.align 16
conclusion:
    addq $3376, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3376, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


