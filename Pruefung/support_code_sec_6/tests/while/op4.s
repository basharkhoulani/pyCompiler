	.align 16
block_198:
    movq %rcx, %rdi
    movq %r10, -3280(%rbp)
    movq %r8, -3288(%rbp)
    movq %rsi, -3296(%rbp)
    movq %rcx, -3304(%rbp)
    movq %r9, -3312(%rbp)
    movq %rdx, -3320(%rbp)
    callq print_int
    movq -3280(%rbp), %r10
    movq -3288(%rbp), %r8
    movq -3296(%rbp), %rsi
    movq -3304(%rbp), %rcx
    movq -3312(%rbp), %r9
    movq -3320(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_200:
    subq $1, %rcx
    jmp loop_199

	.align 16
loop_199:
    cmpq $1, %rcx
    jge block_200
    jmp block_198

	.align 16
start:
    movq $10, %rcx
    jmp loop_199

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


