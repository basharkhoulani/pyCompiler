	.align 16
block_187:
    movq %rcx, %rdi
    movq %r9, -3280(%rbp)
    movq %rdx, -3288(%rbp)
    movq %rcx, -3296(%rbp)
    movq %r10, -3304(%rbp)
    movq %r8, -3312(%rbp)
    movq %rsi, -3320(%rbp)
    callq print_int
    movq -3280(%rbp), %r9
    movq -3288(%rbp), %rdx
    movq -3296(%rbp), %rcx
    movq -3304(%rbp), %r10
    movq -3312(%rbp), %r8
    movq -3320(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_189:
    addq %rdx, %rcx
    subq $1, %rdx
    jmp loop_188

	.align 16
loop_188:
    cmpq $0, %rdx
    jg block_189
    jmp block_187

	.align 16
start:
    movq $0, %rcx
    movq $5, %rdx
    jmp loop_188

	.align 16
conclusion:
    addq $3360, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3360, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


