	.align 16
block_207:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_209:
    subq $1, %rcx
    jmp loop_208

	.align 16
loop_208:
    cmpq $0, %rcx
    jg block_209
    jmp block_207

	.align 16
start:
    movq $10, %rcx
    jmp loop_208

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


