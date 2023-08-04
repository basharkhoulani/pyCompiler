	.align 16
start:
    movq $40, %rcx
    addq $2, %rcx
    movq %rcx, %rdi
    movq %r9, -648(%rbp)
    movq %rdx, -656(%rbp)
    movq %rcx, -664(%rbp)
    movq %r10, -672(%rbp)
    movq %r8, -680(%rbp)
    movq %rsi, -688(%rbp)
    callq print_int
    movq -648(%rbp), %r9
    movq -656(%rbp), %rdx
    movq -664(%rbp), %rcx
    movq -672(%rbp), %r10
    movq -680(%rbp), %r8
    movq -688(%rbp), %rsi
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


