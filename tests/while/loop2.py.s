	.align 16
block_0:
    movq $1, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_2:
    movq $0, %rdi
    callq print_int
    jmp loop_1

	.align 16
loop_1:
    movq $1, %rax
    cmpq $2, %rax
    je block_2
    jmp block_0

	.align 16
loop_3:
    jmp loop_1

	.align 16
start:
    jmp loop_3

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


