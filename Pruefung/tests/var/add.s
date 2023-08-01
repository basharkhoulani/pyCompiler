	.align 16
start:
    movq $40, %rcx
    addq $2, %rcx
    movq %rcx, %rdi
    movq %rsi, -648(%rbp)
    movq %rdx, -656(%rbp)
    movq %r10, -664(%rbp)
    movq %r9, -672(%rbp)
    movq %r8, -680(%rbp)
    movq %rcx, -688(%rbp)
    callq print_int
    movq -648(%rbp), %rsi
    movq -656(%rbp), %rdx
    movq -664(%rbp), %r10
    movq -672(%rbp), %r9
    movq -680(%rbp), %r8
    movq -688(%rbp), %rcx
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


