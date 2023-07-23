	.align 16
block_103:
    movq $0, %rax
    jmp conclusion

	.align 16
block_104:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    subq $4, %rcx
    movq %rcx, %rdi
    callq print_int
    jmp block_103

	.align 16
block_105:
    movq $1, %rcx
    subq $2, %rcx
    subq $3, %rcx
    movq %rcx, %rdi
    callq print_int
    jmp block_103

	.align 16
block_106:
    movq -328(%rbp), %rax
    movq %rax, -336(%rbp)
    addq %rdx, -336(%rbp)
    movq -336(%rbp), %rdx
    addq %r8, %rdx
    addq -344(%rbp), %rdx
    addq -352(%rbp), %rdx
    addq %r10, %rdx
    addq %r9, %rdx
    addq %rsi, %rdx
    addq %rcx, %rdx
    movq %rdx, %rcx
    addq %r15, %rcx
    addq %r11, %rcx
    movq %rcx, %rdi
    callq print_int
    jmp block_103

	.align 16
block_107:
    movq $10, %r11
    negq %r11
    jmp block_106

	.align 16
block_108:
    movq $10, %r11
    jmp block_106

	.align 16
block_109:
    cmpq $1, %rcx
    je block_104
    jmp block_105

	.align 16
block_110:
    movq $1, -328(%rbp)
    movq $1, %rdx
    movq $1, %r8
    movq $1, -344(%rbp)
    movq $1, -352(%rbp)
    movq $1, %r10
    movq $1, %r9
    movq $1, %rsi
    movq $1, %rcx
    movq $1, %r15
    cmpq $1, %r11
    je block_107
    jmp block_108

	.align 16
start:
    callq read_int
    movq %rax, %r11
    callq read_int
    movq %rax, %rcx
    cmpq $0, %r11
    je block_109
    jmp block_110

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


