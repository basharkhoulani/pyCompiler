	.align 16
block_0:
    movq $0, %rax
    jmp conclusion

	.align 16
block_1:
    movq $0, %rdi
    callq print_int
    jmp block_0

	.align 16
block_2:
    movq $0, %rdi
    callq print_int
    jmp block_0

	.align 16
start:
    jmp block_2

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


