	.align 16
block_234:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_236:
    movq $5, %rcx
    addq %rdx, %rcx
    addq $1, %rsi
    jmp loop_235

	.align 16
loop_235:
    cmpq $2, %rsi
    jl block_236
    jmp block_234

	.align 16
start:
    movq $0, %rcx
    callq read_int
    movq %rax, %rdx
    movq $0, %rsi
    jmp loop_235

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


