	.align 16
start:
    movq $2, %rcx
    movq $2, %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %rsi, -328(%rbp)
    movq %rdx, -336(%rbp)
    movq %r10, -344(%rbp)
    movq %r9, -352(%rbp)
    movq %r8, -360(%rbp)
    movq %rcx, -368(%rbp)
    callq print_int
    movq -328(%rbp), %rsi
    movq -336(%rbp), %rdx
    movq -344(%rbp), %r10
    movq -352(%rbp), %r9
    movq -360(%rbp), %r8
    movq -368(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $400, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $400, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


