	.align 16
block_138:
    movq $0, %rax
    jmp conclusion

	.align 16
block_139:
    movq $42, %rdi
    callq print_int
    jmp block_138

	.align 16
block_140:
    movq $0, %rdi
    callq print_int
    jmp block_138

	.align 16
block_141:
    addq %rdx, %rcx
    cmpq $2, %rcx
    jg block_139
    jmp block_140

	.align 16
block_142:
    movq $0, %rdi
    callq print_int
    jmp block_138

	.align 16
block_143:
    cmpq $1, %rdx
    jg block_141
    jmp block_142

	.align 16
block_144:
    movq $0, %rdi
    callq print_int
    jmp block_138

	.align 16
block_145:
    cmpq $1, %rcx
    jge block_143
    jmp block_144

	.align 16
block_146:
    movq $0, %rdi
    callq print_int
    jmp block_138

	.align 16
block_147:
    cmpq $0, %rdx
    jg block_145
    jmp block_146

	.align 16
block_148:
    movq $0, %rdi
    callq print_int
    jmp block_138

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    callq read_int
    movq %rax, %rdx
    cmpq $0, %rcx
    jg block_147
    jmp block_148

	.align 16
conclusion:
    addq $32, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    jmp start


