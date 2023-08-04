	.align 16
start:
    movq %r10, -488(%rbp)
    movq %r8, -496(%rbp)
    movq %rsi, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r9, -520(%rbp)
    movq %rdx, -528(%rbp)
    callq read_int
    movq -488(%rbp), %r10
    movq -496(%rbp), %r8
    movq -504(%rbp), %rsi
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r9
    movq -528(%rbp), %rdx
    movq %rax, %rcx
    movq %r10, -488(%rbp)
    movq %r8, -496(%rbp)
    movq %rsi, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r9, -520(%rbp)
    movq %rdx, -528(%rbp)
    callq read_int
    movq -488(%rbp), %r10
    movq -496(%rbp), %r8
    movq -504(%rbp), %rsi
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r9
    movq -528(%rbp), %rdx
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %r10, -488(%rbp)
    movq %r8, -496(%rbp)
    movq %rsi, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r9, -520(%rbp)
    movq %rdx, -528(%rbp)
    callq read_int
    movq -488(%rbp), %r10
    movq -496(%rbp), %r8
    movq -504(%rbp), %rsi
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r9
    movq -528(%rbp), %rdx
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %r10, -488(%rbp)
    movq %r8, -496(%rbp)
    movq %rsi, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r9, -520(%rbp)
    movq %rdx, -528(%rbp)
    callq print_int
    movq -488(%rbp), %r10
    movq -496(%rbp), %r8
    movq -504(%rbp), %rsi
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r9
    movq -528(%rbp), %rdx
    movq %rcx, %rdi
    movq %r10, -488(%rbp)
    movq %r8, -496(%rbp)
    movq %rsi, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r9, -520(%rbp)
    movq %rdx, -528(%rbp)
    callq print_int
    movq -488(%rbp), %r10
    movq -496(%rbp), %r8
    movq -504(%rbp), %rsi
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r9
    movq -528(%rbp), %rdx
    movq %rcx, %rdi
    movq %r10, -488(%rbp)
    movq %r8, -496(%rbp)
    movq %rsi, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r9, -520(%rbp)
    movq %rdx, -528(%rbp)
    callq print_int
    movq -488(%rbp), %r10
    movq -496(%rbp), %r8
    movq -504(%rbp), %rsi
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r9
    movq -528(%rbp), %rdx
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


