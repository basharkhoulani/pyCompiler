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
    movq %r10, -168(%rbp)
    movq %rsi, -176(%rbp)
    movq %r8, -184(%rbp)
    movq %rcx, -192(%rbp)
    movq %rdx, -200(%rbp)
    movq %r9, -208(%rbp)
    callq print_int
    movq -168(%rbp), %r10
    movq -176(%rbp), %rsi
    movq -184(%rbp), %r8
    movq -192(%rbp), %rcx
    movq -200(%rbp), %rdx
    movq -208(%rbp), %r9
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


