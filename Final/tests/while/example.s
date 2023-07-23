	.align 16
block_169:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_171:
    addq %rdx, %rcx
    subq $1, %rdx
    jmp loop_170

	.align 16
loop_170:
    cmpq $0, %rdx
    jg block_171
    jmp block_169

	.align 16
start:
    movq $0, %rcx
    movq $5, %rdx
    jmp loop_170

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


