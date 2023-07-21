	.align 16
block_125:
    movq $0, %rax
    jmp conclusion

	.align 16
block_126:
    movq $42, %rdi
    callq print_int
    jmp block_125

	.align 16
block_127:
    movq $0, %rdi
    callq print_int
    jmp block_125

	.align 16
block_128:
    movq -1720(%rbp), %rax
    movq %rax, -1728(%rbp)
    movq -1736(%rbp), %rax
    addq %rax, -1728(%rbp)
    cmpq $2, -1728(%rbp)
    jg block_126
    jmp block_127

	.align 16
block_129:
    movq $0, %rdi
    callq print_int
    jmp block_125

	.align 16
block_130:
    cmpq $1, -1736(%rbp)
    jg block_128
    jmp block_129

	.align 16
block_131:
    movq $0, %rdi
    callq print_int
    jmp block_125

	.align 16
block_132:
    cmpq $1, -1720(%rbp)
    jge block_130
    jmp block_131

	.align 16
block_133:
    movq $0, %rdi
    callq print_int
    jmp block_125

	.align 16
block_134:
    cmpq $0, -1736(%rbp)
    jg block_132
    jmp block_133

	.align 16
block_135:
    movq $0, %rdi
    callq print_int
    jmp block_125

	.align 16
start:
    callq read_int
    movq %rax, -1720(%rbp)
    callq read_int
    movq %rax, -1736(%rbp)
    cmpq $0, -1720(%rbp)
    jg block_134
    jmp block_135

	.align 16
conclusion:
    addq $1744, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1744, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


