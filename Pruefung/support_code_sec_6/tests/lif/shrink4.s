	.align 16
block_112:
    movq %rcx, %rdi
    movq %r10, -2160(%rbp)
    movq %r8, -2168(%rbp)
    movq %rsi, -2176(%rbp)
    movq %rcx, -2184(%rbp)
    movq %r9, -2192(%rbp)
    movq %rdx, -2200(%rbp)
    callq print_int
    movq -2160(%rbp), %r10
    movq -2168(%rbp), %r8
    movq -2176(%rbp), %rsi
    movq -2184(%rbp), %rcx
    movq -2192(%rbp), %r9
    movq -2200(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
start:
    movq $1, %rcx
    jmp block_112

	.align 16
conclusion:
    addq $2240, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2240, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


