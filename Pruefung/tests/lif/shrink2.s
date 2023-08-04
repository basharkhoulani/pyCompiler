	.align 16
block_166:
    movq $0, %rax
    jmp conclusion

	.align 16
block_167:
    movq $0, %rdi
    movq %r9, -2800(%rbp)
    movq %rdx, -2808(%rbp)
    movq %rcx, -2816(%rbp)
    movq %r10, -2824(%rbp)
    movq %r8, -2832(%rbp)
    movq %rsi, -2840(%rbp)
    callq print_int
    movq -2800(%rbp), %r9
    movq -2808(%rbp), %rdx
    movq -2816(%rbp), %rcx
    movq -2824(%rbp), %r10
    movq -2832(%rbp), %r8
    movq -2840(%rbp), %rsi
    jmp block_166

	.align 16
block_168:
    movq $1, %rdi
    movq %r9, -2800(%rbp)
    movq %rdx, -2808(%rbp)
    movq %rcx, -2816(%rbp)
    movq %r10, -2824(%rbp)
    movq %r8, -2832(%rbp)
    movq %rsi, -2840(%rbp)
    callq print_int
    movq -2800(%rbp), %r9
    movq -2808(%rbp), %rdx
    movq -2816(%rbp), %rcx
    movq -2824(%rbp), %r10
    movq -2832(%rbp), %r8
    movq -2840(%rbp), %rsi
    jmp block_166

	.align 16
start:
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


