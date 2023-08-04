	.align 16
block_166:
    movq %rcx, %rdi
    movq %r10, -2800(%rbp)
    movq %r8, -2808(%rbp)
    movq %rsi, -2816(%rbp)
    movq %rcx, -2824(%rbp)
    movq %r9, -2832(%rbp)
    movq %rdx, -2840(%rbp)
    callq print_int
    movq -2800(%rbp), %r10
    movq -2808(%rbp), %r8
    movq -2816(%rbp), %rsi
    movq -2824(%rbp), %rcx
    movq -2832(%rbp), %r9
    movq -2840(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_167:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    jmp block_166

	.align 16
block_168:
    movq $1, %rcx
    negq %rcx
    movq $2, %rdx
    negq %rdx
    addq %rdx, %rcx
    movq $3, %rdx
    negq %rdx
    addq %rdx, %rcx
    jmp block_166

	.align 16
start:
    movq $4, %rcx
    addq $2, %rcx
    cmpq $0, %rcx
    jg block_167
    jmp block_168

	.align 16
conclusion:
    addq $2880, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2880, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


