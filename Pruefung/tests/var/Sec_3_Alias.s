	.align 16
start:
    movq $42, %rcx
    movq $0, %rdx
    addq %rdx, %rcx
    addq %rdx, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %rsi, -968(%rbp)
    movq %rdx, -976(%rbp)
    movq %r10, -984(%rbp)
    movq %r9, -992(%rbp)
    movq %r8, -1000(%rbp)
    movq %rcx, -1008(%rbp)
    callq print_int
    movq -968(%rbp), %rsi
    movq -976(%rbp), %rdx
    movq -984(%rbp), %r10
    movq -992(%rbp), %r9
    movq -1000(%rbp), %r8
    movq -1008(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1040, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1040, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


