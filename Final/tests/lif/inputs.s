	.align 16
block_119:
    movq $0, %rax
    jmp conclusion

	.align 16
block_120:
    movq %rcx, %rdi
    callq print_int
    jmp block_119

	.align 16
block_121:
    movq $1, %rcx
    jmp block_120

	.align 16
block_122:
    movq $42, %rcx
    jmp block_120

	.align 16
block_123:
    callq read_int
    movq %rax, %rcx
    movq $42, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    jmp block_119

	.align 16
block_124:
    callq read_int
    movq %rax, %rcx
    cmpq $0, %rcx
    je block_121
    jmp block_122

	.align 16
block_125:
    callq read_int
    movq %rax, %rcx
    callq read_int
    movq %rax, %rdx
    cmpq %rdx, %rcx
    jge block_123
    jmp block_124

	.align 16
start:
    callq read_int
    movq %rax, %rdx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rdx
    je block_125
    jmp block_124

	.align 16
conclusion:
    addq $352, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $352, %rsp
    jmp start


