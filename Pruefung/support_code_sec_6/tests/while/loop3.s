	.align 16
block_215:
    movq %rdx, %rdi
    movq %r10, -3680(%rbp)
    movq %r8, -3688(%rbp)
    movq %rsi, -3696(%rbp)
    movq %rcx, -3704(%rbp)
    movq %r9, -3712(%rbp)
    movq %rdx, -3720(%rbp)
    callq print_int
    movq -3680(%rbp), %r10
    movq -3688(%rbp), %r8
    movq -3696(%rbp), %rsi
    movq -3704(%rbp), %rcx
    movq -3712(%rbp), %r9
    movq -3720(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_217:
    subq $1, %rdx
    jmp loop_216

	.align 16
block_219:
    subq $1, %rcx
    jmp loop_218

	.align 16
loop_218:
    cmpq $0, %rcx
    jne block_219
    jmp block_217

	.align 16
block_220:
    movq $2, %rcx
    jmp loop_218

	.align 16
loop_216:
    cmpq $0, %rdx
    jg block_220
    jmp block_215

	.align 16
start:
    movq $20, %rdx
    jmp loop_216

	.align 16
conclusion:
    addq $3760, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3760, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


