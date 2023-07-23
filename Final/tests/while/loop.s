	.align 16
block_188:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_190:
    movq %r8, %rcx
    addq %rcx, %r8
    addq $1, %rdx
    jmp loop_189

	.align 16
loop_189:
    cmpq %rsi, %rdx
    jl block_190
    jmp block_188

	.align 16
start:
    movq $0, %rcx
    movq $1, %r8
    movq $0, %rdx
    callq read_int
    movq %rax, %rsi
    jmp loop_189

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


