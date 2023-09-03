	.align 16
start:
    movq $4, %rcx
    addq $4, %rcx
    movq $40, %rdx
    addq %rcx, %rdx
    movq %rdx, %rcx
    addq $2, %rcx
    movq %rcx, %rdi
    movq %r9, -728(%rbp)
    movq %rdx, -736(%rbp)
    movq %rcx, -744(%rbp)
    movq %r10, -752(%rbp)
    movq %r8, -760(%rbp)
    movq %rsi, -768(%rbp)
    callq print_int
    movq -728(%rbp), %r9
    movq -736(%rbp), %rdx
    movq -744(%rbp), %rcx
    movq -752(%rbp), %r10
    movq -760(%rbp), %r8
    movq -768(%rbp), %rsi
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


