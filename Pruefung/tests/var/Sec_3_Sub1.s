	.align 16
start:
    movq $2, %rcx
    movq $48, %rdx
    subq %rcx, %rdx
    movq %rdx, %rcx
    subq $4, %rcx
    movq %rcx, %rdi
    movq %rsi, -408(%rbp)
    movq %rdx, -416(%rbp)
    movq %r10, -424(%rbp)
    movq %r9, -432(%rbp)
    movq %r8, -440(%rbp)
    movq %rcx, -448(%rbp)
    callq print_int
    movq -408(%rbp), %rsi
    movq -416(%rbp), %rdx
    movq -424(%rbp), %r10
    movq -432(%rbp), %r9
    movq -440(%rbp), %r8
    movq -448(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $480, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $480, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


