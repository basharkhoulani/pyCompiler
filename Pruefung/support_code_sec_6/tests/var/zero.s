	.align 16
start:
    movq $0, %rdi
    movq %r10, -648(%rbp)
    movq %r8, -656(%rbp)
    movq %rsi, -664(%rbp)
    movq %rcx, -672(%rbp)
    movq %r9, -680(%rbp)
    movq %rdx, -688(%rbp)
    callq print_int
    movq -648(%rbp), %r10
    movq -656(%rbp), %r8
    movq -664(%rbp), %rsi
    movq -672(%rbp), %rcx
    movq -680(%rbp), %r9
    movq -688(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $720, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $720, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


