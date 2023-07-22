	.align 16
block_0:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_2:
    addq %rcx, %rcx
    addq $1, %rdx
    jmp loop_1

	.align 16
loop_1:
    cmpq %rsi, %rdx
    jl block_2
    jmp block_0

	.align 16
start:
    movq $0, %rcx
    movq $1, %rcx
    movq $0, %rdx
    movq $10, %rsi
    jmp loop_1

	.align 16
conclusion:
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


