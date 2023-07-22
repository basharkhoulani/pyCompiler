	.align 16
block_116:
    movq $0, %rax
    jmp conclusion

	.align 16
block_117:
    movq $0, %rdi
    callq print_int
    jmp block_116

	.align 16
block_118:
    movq $1, %rdi
    callq print_int
    jmp block_116

	.align 16
block_119:
    movq $1, %rdi
    callq print_int
    jmp block_118

	.align 16
block_120:
    movq $0, %rdi
    callq print_int
    jmp block_118

	.align 16
block_121:
    movq $1, %rdi
    callq print_int
    jmp block_120

	.align 16
block_122:
    movq $0, %rdi
    callq print_int
    jmp block_120

	.align 16
block_123:
    movq $1, %rdi
    callq print_int
    jmp block_121

	.align 16
block_124:
    movq $0, %rdi
    callq print_int
    jmp block_121

	.align 16
start:
    jmp block_123

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1648, %rsp
    jmp start

	.align 16
conclusion:
    addq $1648, %rsp
    popq %rbp
    retq 


