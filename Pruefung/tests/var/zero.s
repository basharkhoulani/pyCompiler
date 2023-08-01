	.align 16
start:
    movq $0, %rdi
    movq %rsi, -88(%rbp)
    movq %rdx, -96(%rbp)
    movq %r10, -104(%rbp)
    movq %r9, -112(%rbp)
    movq %r8, -120(%rbp)
    movq %rcx, -128(%rbp)
    callq print_int
    movq -88(%rbp), %rsi
    movq -96(%rbp), %rdx
    movq -104(%rbp), %r10
    movq -112(%rbp), %r9
    movq -120(%rbp), %r8
    movq -128(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $160, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


