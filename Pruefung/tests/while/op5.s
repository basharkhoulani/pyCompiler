	.align 16
block_223:
    movq %rcx, %rdi
    movq %rsi, -3848(%rbp)
    movq %rdx, -3856(%rbp)
    movq %r10, -3864(%rbp)
    movq %r9, -3872(%rbp)
    movq %r8, -3880(%rbp)
    movq %rcx, -3888(%rbp)
    callq print_int
    movq -3848(%rbp), %rsi
    movq -3856(%rbp), %rdx
    movq -3864(%rbp), %r10
    movq -3872(%rbp), %r9
    movq -3880(%rbp), %r8
    movq -3888(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
block_225:
    subq $1, %rcx
    jmp loop_224

	.align 16
loop_224:
    cmpq $0, %rcx
    jne block_225
    jmp block_223

	.align 16
start:
    movq $10, %rcx
    jmp loop_224

	.align 16
conclusion:
    addq $3920, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3920, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


