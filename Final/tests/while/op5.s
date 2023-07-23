	.align 16
block_213:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_215:
    subq $1, %rcx
    jmp loop_214

	.align 16
loop_214:
    cmpq $0, %rcx
    jne block_215
    jmp block_213

	.align 16
start:
    movq $10, %rcx
    jmp loop_214

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


