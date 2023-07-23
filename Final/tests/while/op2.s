	.align 16
block_204:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_206:
    addq $1, %rcx
    jmp loop_205

	.align 16
loop_205:
    cmpq $10, %rcx
    jle block_206
    jmp block_204

	.align 16
start:
    movq $0, %rcx
    jmp loop_205

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


