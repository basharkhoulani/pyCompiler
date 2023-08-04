	.align 16
start:
    movq $2, %rcx
    movq $48, %rdx
    subq %rcx, %rdx
    movq %rdx, %rcx
    subq $4, %rcx
    movq %rcx, %rdi
    movq %r10, -568(%rbp)
    movq %r8, -576(%rbp)
    movq %rsi, -584(%rbp)
    movq %rcx, -592(%rbp)
    movq %r9, -600(%rbp)
    movq %rdx, -608(%rbp)
    callq print_int
    movq -568(%rbp), %r10
    movq -576(%rbp), %r8
    movq -584(%rbp), %rsi
    movq -592(%rbp), %rcx
    movq -600(%rbp), %r9
    movq -608(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $640, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $640, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


