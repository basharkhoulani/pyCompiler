	.align 16
block_0:
    movq $0, %rax
    jmp conclusion

	.align 16
block_2:
    movq -8(%rbp), %rdi
    callq print_int
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -24(%rbp), %rax
    addq %rax, -16(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    addq $1, -32(%rbp)
    jmp loop_1

	.align 16
loop_1:
    movq -40(%rbp), %rax
    cmpq %rax, -32(%rbp)
    jl block_2
    jmp block_0

	.align 16
start:
    callq read_int
    movq %rax, -40(%rbp)
    movq $0, -8(%rbp)
    movq $1, -24(%rbp)
    movq $0, -32(%rbp)
    jmp loop_1

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    jmp start

	.align 16
conclusion:
    addq $48, %rsp
    popq %rbp
    retq 


