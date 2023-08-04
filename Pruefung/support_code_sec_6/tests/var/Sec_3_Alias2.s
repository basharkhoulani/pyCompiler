	.align 16
start:
    movq $1, %rcx
    movq %rcx, %rdi
    movq %r10, -728(%rbp)
    movq %r8, -736(%rbp)
    movq %rsi, -744(%rbp)
    movq %rcx, -752(%rbp)
    movq %r9, -760(%rbp)
    movq %rdx, -768(%rbp)
    callq print_int
    movq -728(%rbp), %r10
    movq -736(%rbp), %r8
    movq -744(%rbp), %rsi
    movq -752(%rbp), %rcx
    movq -760(%rbp), %r9
    movq -768(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $800, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $800, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


