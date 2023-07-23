	.align 16
block_201:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_203:
    addq $1, %rcx
    jmp loop_202

	.align 16
loop_202:
    cmpq $10, %rcx
    jl block_203
    jmp block_201

	.align 16
start:
    movq $0, %rcx
    jmp loop_202

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


