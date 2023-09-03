	.align 16
block_0:
    movq -8(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_2:
    subq $1, -8(%rbp)
    jmp loop_1

	.align 16
block_4:
    subq $1, -16(%rbp)
    jmp loop_3

	.align 16
loop_3:
    cmpq $0, -16(%rbp)
    jne block_4
    jmp block_2

	.align 16
block_5:
    movq $2, -16(%rbp)
    jmp loop_3

	.align 16
loop_1:
    cmpq $0, -8(%rbp)
    jg block_5
    jmp block_0

	.align 16
start:
    movq $100, -8(%rbp)
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


