	.align 16
block_127:
    movq $0, %rax
    jmp conclusion

	.align 16
block_128:
    movq $42, %rdi
    callq print_int
    jmp block_127

	.align 16
block_129:
    movq $0, %rdi
    callq print_int
    jmp block_127

	.align 16
block_130:
    addq %rdx, %rcx
    cmpq $2, %rcx
    jg block_128
    jmp block_129

	.align 16
block_131:
    movq $0, %rdi
    callq print_int
    jmp block_127

	.align 16
block_132:
    cmpq $1, %rdx
    jg block_130
    jmp block_131

	.align 16
block_133:
    movq $0, %rdi
    callq print_int
    jmp block_127

	.align 16
block_134:
    cmpq $1, %rcx
    jge block_132
    jmp block_133

	.align 16
block_135:
    movq $0, %rdi
    callq print_int
    jmp block_127

	.align 16
block_136:
    cmpq $0, %rdx
    jg block_134
    jmp block_135

	.align 16
block_137:
    movq $0, %rdi
    callq print_int
    jmp block_127

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    callq read_int
    movq %rax, %rdx
    cmpq $0, %rcx
    jg block_136
    jmp block_137

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


