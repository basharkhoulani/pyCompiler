	.align 16
block_180:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_182:
    addq %rsi, %rcx
    jmp loop_181

	.align 16
loop_181:
    cmpq %rdx, %rcx
    jl block_182
    jmp block_180

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    movq $1, %rsi
    callq read_int
    movq %rax, %rdx
    jmp loop_181

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


