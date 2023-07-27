	.align 16
block_0:
    movq %rdx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_2:
    addq %rcx, %rdx
    subq $1, %rcx
    jmp loop_1

	.align 16
loop_1:
    cmpq $0, %rcx
    jg block_2
    jmp block_0

	.align 16
start:
    movq $0, %rdx
    movq $5, %rcx
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


