	.align 16
block_195:
    movq %rdx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_197:
    subq $1, %rdx
    jmp loop_196

	.align 16
block_199:
    subq $1, %rcx
    jmp loop_198

	.align 16
loop_198:
    cmpq $0, %rcx
    jne block_199
    jmp block_197

	.align 16
block_200:
    movq $2, %rcx
    jmp loop_198

	.align 16
loop_196:
    cmpq $0, %rdx
    jg block_200
    jmp block_195

	.align 16
start:
    movq $20, %rdx
    jmp loop_196

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


