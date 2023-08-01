	.align 16
block_166:
    movq $0, %rax
    jmp conclusion

	.align 16
block_167:
    movq $0, %rdi
    movq %rsi, -2808(%rbp)
    movq %rdx, -2816(%rbp)
    movq %r10, -2824(%rbp)
    movq %r9, -2832(%rbp)
    movq %r8, -2840(%rbp)
    movq %rcx, -2848(%rbp)
    callq print_int
    movq -2808(%rbp), %rsi
    movq -2816(%rbp), %rdx
    movq -2824(%rbp), %r10
    movq -2832(%rbp), %r9
    movq -2840(%rbp), %r8
    movq -2848(%rbp), %rcx
    jmp block_166

	.align 16
block_168:
    movq $1, %rdi
    movq %rsi, -2808(%rbp)
    movq %rdx, -2816(%rbp)
    movq %r10, -2824(%rbp)
    movq %r9, -2832(%rbp)
    movq %r8, -2840(%rbp)
    movq %rcx, -2848(%rbp)
    callq print_int
    movq -2808(%rbp), %rsi
    movq -2816(%rbp), %rdx
    movq -2824(%rbp), %r10
    movq -2832(%rbp), %r9
    movq -2840(%rbp), %r8
    movq -2848(%rbp), %rcx
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


