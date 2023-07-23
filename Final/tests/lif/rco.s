	.align 16
block_149:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_150:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    jmp block_149

	.align 16
block_151:
    movq $1, %rcx
    negq %rcx
    movq $2, %rdx
    negq %rdx
    addq %rdx, %rcx
    movq $3, %rdx
    negq %rdx
    addq %rdx, %rcx
    jmp block_149

	.align 16
start:
    movq $4, %rcx
    addq $2, %rcx
    cmpq $0, %rcx
    jg block_150
    jmp block_151

	.align 16
conclusion:
    addq $352, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $352, %rsp
    jmp start


