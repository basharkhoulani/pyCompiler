	.align 16
start:
    movq %r10, -1560(%rbp)
    movq %r8, -1568(%rbp)
    movq %rsi, -1576(%rbp)
    movq %rcx, -1584(%rbp)
    movq %r9, -1592(%rbp)
    movq %rdx, -1600(%rbp)
    callq read_int
    movq -1560(%rbp), %r10
    movq -1568(%rbp), %r8
    movq -1576(%rbp), %rsi
    movq -1584(%rbp), %rcx
    movq -1592(%rbp), %r9
    movq -1600(%rbp), %rdx
    movq %rax, %rcx
    movq %r10, -1560(%rbp)
    movq %r8, -1568(%rbp)
    movq %rsi, -1576(%rbp)
    movq %rcx, -1584(%rbp)
    movq %r9, -1592(%rbp)
    movq %rdx, -1600(%rbp)
    callq read_int
    movq -1560(%rbp), %r10
    movq -1568(%rbp), %r8
    movq -1576(%rbp), %rsi
    movq -1584(%rbp), %rcx
    movq -1592(%rbp), %r9
    movq -1600(%rbp), %rdx
    movq %rax, %rdx
    addq %rdx, %rcx
    addq $42, %rcx
    movq %rcx, %rdi
    movq %r10, -1560(%rbp)
    movq %r8, -1568(%rbp)
    movq %rsi, -1576(%rbp)
    movq %rcx, -1584(%rbp)
    movq %r9, -1592(%rbp)
    movq %rdx, -1600(%rbp)
    callq print_int
    movq -1560(%rbp), %r10
    movq -1568(%rbp), %r8
    movq -1576(%rbp), %rsi
    movq -1584(%rbp), %rcx
    movq -1592(%rbp), %r9
    movq -1600(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1632, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1632, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


