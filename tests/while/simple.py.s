	.align 16
block_0:
    movq -8(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_2:
    addq $1, -8(%rbp)
    jmp loop_1

	.align 16
loop_1:
    cmpq $10, -8(%rbp)
    jl block_2
    jmp block_0

	.align 16
start:
    movq $0, -8(%rbp)
    jmp loop_1

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    jmp start

	.align 16
conclusion:
    addq $16, %rsp
    popq %rbp
    retq 


