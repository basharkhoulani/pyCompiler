	.align 16
start:
    movq %rsi, -888(%rbp)
    movq %rdx, -896(%rbp)
    movq %r10, -904(%rbp)
    movq %r9, -912(%rbp)
    movq %r8, -920(%rbp)
    movq %rcx, -928(%rbp)
    callq read_int
    movq -888(%rbp), %rsi
    movq -896(%rbp), %rdx
    movq -904(%rbp), %r10
    movq -912(%rbp), %r9
    movq -920(%rbp), %r8
    movq -928(%rbp), %rcx
    movq %rax, %rcx
    movq %rsi, -888(%rbp)
    movq %rdx, -896(%rbp)
    movq %r10, -904(%rbp)
    movq %r9, -912(%rbp)
    movq %r8, -920(%rbp)
    movq %rcx, -928(%rbp)
    callq read_int
    movq -888(%rbp), %rsi
    movq -896(%rbp), %rdx
    movq -904(%rbp), %r10
    movq -912(%rbp), %r9
    movq -920(%rbp), %r8
    movq -928(%rbp), %rcx
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %rsi, -888(%rbp)
    movq %rdx, -896(%rbp)
    movq %r10, -904(%rbp)
    movq %r9, -912(%rbp)
    movq %r8, -920(%rbp)
    movq %rcx, -928(%rbp)
    callq read_int
    movq -888(%rbp), %rsi
    movq -896(%rbp), %rdx
    movq -904(%rbp), %r10
    movq -912(%rbp), %r9
    movq -920(%rbp), %r8
    movq -928(%rbp), %rcx
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %rsi, -888(%rbp)
    movq %rdx, -896(%rbp)
    movq %r10, -904(%rbp)
    movq %r9, -912(%rbp)
    movq %r8, -920(%rbp)
    movq %rcx, -928(%rbp)
    callq print_int
    movq -888(%rbp), %rsi
    movq -896(%rbp), %rdx
    movq -904(%rbp), %r10
    movq -912(%rbp), %r9
    movq -920(%rbp), %r8
    movq -928(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $960, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $960, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


