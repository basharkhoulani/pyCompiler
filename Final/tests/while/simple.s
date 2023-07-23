	.align 16
block_231:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_233:
    addq $1, %rcx
    jmp loop_232

	.align 16
loop_232:
    cmpq $10, %rcx
    jl block_233
    jmp block_231

	.align 16
start:
    movq $0, %rcx
    jmp loop_232

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


