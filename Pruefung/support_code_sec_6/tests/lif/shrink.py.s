	.align 16
block_3:
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -24(%rbp), %rax
    addq %rax, -16(%rbp)
    movq -16(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_4:
    movq $2, -24(%rbp)
    jmp block_3

	.align 16
block_5:
    movq $0, -24(%rbp)
    jmp block_3

	.align 16
block_6:
    cmpq $0, None
    je block_4
    jmp block_5

	.align 16
block_7:
    movq $4, -8(%rbp)
    jmp block_6

	.align 16
block_8:
    movq $0, %rdi
    callq print_int
    jmp block_7

	.align 16
block_9:
    movq $1, %rdi
    callq print_int
    jmp block_7

	.align 16
block_10:
    movq $1, %rdi
    callq print_int
    jmp block_9

	.align 16
block_11:
    movq $0, %rdi
    callq print_int
    jmp block_9

	.align 16
block_12:
    movq $1, %rdi
    callq print_int
    jmp block_11

	.align 16
block_13:
    movq $0, %rdi
    callq print_int
    jmp block_11

	.align 16
block_14:
    movq $1, %rdi
    callq print_int
    jmp block_12

	.align 16
block_15:
    movq $0, %rdi
    callq print_int
    jmp block_12

	.align 16
start:
    jmp block_14

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    jmp start

	.align 16
conclusion:
    addq $32, %rsp
    popq %rbp
    retq 


