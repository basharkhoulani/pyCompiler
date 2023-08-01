	.align 16
start:
    movq %rsi, -488(%rbp)
    movq %rdx, -496(%rbp)
    movq %r10, -504(%rbp)
    movq %r9, -512(%rbp)
    movq %r8, -520(%rbp)
    movq %rcx, -528(%rbp)
    callq read_int
    movq -488(%rbp), %rsi
    movq -496(%rbp), %rdx
    movq -504(%rbp), %r10
    movq -512(%rbp), %r9
    movq -520(%rbp), %r8
    movq -528(%rbp), %rcx
    movq %rax, %rcx
    movq %rcx, %rdi
    movq %rsi, -488(%rbp)
    movq %rdx, -496(%rbp)
    movq %r10, -504(%rbp)
    movq %r9, -512(%rbp)
    movq %r8, -520(%rbp)
    movq %rcx, -528(%rbp)
    callq print_int
    movq -488(%rbp), %rsi
    movq -496(%rbp), %rdx
    movq -504(%rbp), %r10
    movq -512(%rbp), %r9
    movq -520(%rbp), %r8
    movq -528(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $560, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $560, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


