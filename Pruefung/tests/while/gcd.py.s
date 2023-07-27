	.align 16
block_0:
    movq -8(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_2:
    movq -16(%rbp), %rax
    subq %rax, -8(%rbp)
    jmp loop_1

	.align 16
block_3:
    movq -8(%rbp), %rax
    subq %rax, -16(%rbp)
    jmp loop_1

	.align 16
block_4:
    movq -16(%rbp), %rax
    cmpq %rax, -8(%rbp)
    jg block_2
    jmp block_3

	.align 16
loop_1:
    cmpq $0, -16(%rbp)
    jne block_4
    jmp block_0

	.align 16
start:
    callq read_int
    movq %rax, -8(%rbp)
    callq read_int
    movq %rax, -16(%rbp)
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


