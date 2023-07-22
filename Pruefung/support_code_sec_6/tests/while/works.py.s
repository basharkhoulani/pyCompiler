	.align 16
block_0:
    movq %rsi, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_2:
    addq $1, %rsi
    addq $1, %rcx
    jmp loop_1

	.align 16
loop_1:
    cmpq %rdx, %rcx
    jl block_2
    jmp block_0

	.align 16
start:
    movq $1, %rsi
    movq $1, %rcx
    movq $1, %rdx
    jmp loop_1

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start

	.align 16
conclusion:
    popq %rbp
    retq 


