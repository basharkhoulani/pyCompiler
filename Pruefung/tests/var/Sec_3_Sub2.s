	.align 16
start:
    movq $6, %rcx
    movq %rcx, %rdx
    subq $2, %rdx
    movq $2, %rcx
    negq %rcx
    addq %rcx, %rdx
    movq %rdx, %rcx
    subq $2, %rcx
    movq %rcx, %rdi
    movq %r9, -168(%rbp)
    movq %rdx, -176(%rbp)
    movq %rcx, -184(%rbp)
    movq %r10, -192(%rbp)
    movq %r8, -200(%rbp)
    movq %rsi, -208(%rbp)
    callq print_int
    movq -168(%rbp), %r9
    movq -176(%rbp), %rdx
    movq -184(%rbp), %rcx
    movq -192(%rbp), %r10
    movq -200(%rbp), %r8
    movq -208(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $240, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $240, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


