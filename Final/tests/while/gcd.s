	.align 16
block_175:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_177:
    subq %rdx, %rcx
    jmp loop_176

	.align 16
block_178:
    subq %rcx, %rdx
    jmp loop_176

	.align 16
block_179:
    cmpq %rdx, %rcx
    jg block_177
    jmp block_178

	.align 16
loop_176:
    cmpq $0, %rdx
    jne block_179
    jmp block_175

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    callq read_int
    movq %rax, %rdx
    jmp loop_176

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


