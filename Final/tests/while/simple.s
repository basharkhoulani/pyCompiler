	.align 16
block_198:
    movq -1936(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_200:
    addq $1, -1936(%rbp)
    jmp loop_199

	.align 16
loop_199:
    cmpq $10, -1936(%rbp)
    jl block_200
    jmp block_198

	.align 16
start:
    movq $0, -1936(%rbp)
    jmp loop_199

	.align 16
conclusion:
    addq $1936, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1936, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


