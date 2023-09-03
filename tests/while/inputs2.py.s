	.align 16
block_2:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_4:
    addq %rdx, %rcx
    addq %rdx, %rcx
    addq %rdx, %rcx
    jmp loop_3

	.align 16
loop_3:
    cmpq %rdx, %rcx
    jl block_4
    jmp block_2

	.align 16
start:
    movq $1, %rdx
    callq read_int
    movq %rax, %rcx
    movq $1, %rdx
    movq $1, %rdx
    callq read_int
    movq %rax, %rdx
    jmp loop_3

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


