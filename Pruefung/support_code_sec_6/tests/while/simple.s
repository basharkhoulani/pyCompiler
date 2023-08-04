	.align 16
block_225:
    movq %rcx, %rdi
    movq %r10, -3840(%rbp)
    movq %r8, -3848(%rbp)
    movq %rsi, -3856(%rbp)
    movq %rcx, -3864(%rbp)
    movq %r9, -3872(%rbp)
    movq %rdx, -3880(%rbp)
    callq print_int
    movq -3840(%rbp), %r10
    movq -3848(%rbp), %r8
    movq -3856(%rbp), %rsi
    movq -3864(%rbp), %rcx
    movq -3872(%rbp), %r9
    movq -3880(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_227:
    addq $1, %rcx
    jmp loop_226

	.align 16
loop_226:
    cmpq $10, %rcx
    jl block_227
    jmp block_225

	.align 16
start:
    movq $0, %rcx
    jmp loop_226

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


