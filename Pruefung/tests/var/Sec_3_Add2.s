	.align 16
start:
    movq $1, %rcx
    movq %rcx, %rdx
    addq %rcx, %rdx
    addq $1, %rdx
    addq $1, %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %rsi, -568(%rbp)
    movq %rdx, -576(%rbp)
    movq %r10, -584(%rbp)
    movq %r9, -592(%rbp)
    movq %r8, -600(%rbp)
    movq %rcx, -608(%rbp)
    callq print_int
    movq -568(%rbp), %rsi
    movq -576(%rbp), %rdx
    movq -584(%rbp), %r10
    movq -592(%rbp), %r9
    movq -600(%rbp), %r8
    movq -608(%rbp), %rcx
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


