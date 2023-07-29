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
    addq %r9, %rsi
    addq %r10, %rsi
    addq %r8, %rsi
    addq -8(%rbp), %rsi
    addq %r15, %rsi
    addq %rcx, %rsi
    movq %rsi, %rcx
    addq -16(%rbp), %rcx
    addq %rdx, %rcx
    addq -24(%rbp), %rcx
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
    movq $1, %rsi
    movq $1, %r9
    movq $1, %r10
    movq $1, %r8
    movq $1, -8(%rbp)
    movq $1, %r15
    movq $1, %rcx
    movq $1, -16(%rbp)
    movq $1, %rdx
    movq $1, -24(%rbp)
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


