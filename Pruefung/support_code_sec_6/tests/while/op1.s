	.align 16
block_216:
    movq -2040(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_218:
    addq $1, -2040(%rbp)
    jmp loop_217

	.align 16
loop_217:
    cmpq $10, -2040(%rbp)
    jl block_218
    jmp block_216

	.align 16
start:
    movq $0, -2040(%rbp)
    jmp loop_217

	.align 16
conclusion:
    addq $2048, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2048, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


