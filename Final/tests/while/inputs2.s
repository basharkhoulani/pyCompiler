	.align 16
block_185:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_187:
    addq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    jmp loop_186

	.align 16
loop_186:
    cmpq %r9, %rcx
    jl block_187
    jmp block_185

	.align 16
start:
    movq $1, %rdx
    callq read_int
    movq %rax, %rcx
    movq $1, %rsi
    movq $1, %r8
    callq read_int
    movq %rax, %r9
    jmp loop_186

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


