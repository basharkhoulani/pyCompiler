	.align 16
start:
    movq $40, %rcx
    addq $2, %rcx
    movq %rcx, %rdi
    movq %r10, -648(%rbp)
    movq %rsi, -656(%rbp)
    movq %r8, -664(%rbp)
    movq %rcx, -672(%rbp)
    movq %rdx, -680(%rbp)
    movq %r9, -688(%rbp)
    callq print_int
    movq -648(%rbp), %r10
    movq -656(%rbp), %rsi
    movq -664(%rbp), %r8
    movq -672(%rbp), %rcx
    movq -680(%rbp), %rdx
    movq -688(%rbp), %r9
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


