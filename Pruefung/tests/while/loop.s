	.align 16
block_196:
    movq %rcx, %rdi
    movq %rsi, -3448(%rbp)
    movq %rdx, -3456(%rbp)
    movq %r10, -3464(%rbp)
    movq %r9, -3472(%rbp)
    movq %r8, -3480(%rbp)
    movq %rcx, -3488(%rbp)
    callq print_int
    movq -3448(%rbp), %rsi
    movq -3456(%rbp), %rdx
    movq -3464(%rbp), %r10
    movq -3472(%rbp), %r9
    movq -3480(%rbp), %r8
    movq -3488(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
block_198:
    movq %rdx, %rcx
    addq %rcx, %rdx
    addq $1, %rsi
    jmp loop_197

	.align 16
loop_197:
    cmpq %r8, %rsi
    jl block_198
    jmp block_196

	.align 16
start:
    movq $0, %rcx
    movq $1, %rdx
    movq $0, %rsi
    movq %rsi, -3448(%rbp)
    movq %rdx, -3456(%rbp)
    movq %r10, -3464(%rbp)
    movq %r9, -3472(%rbp)
    movq %r8, -3480(%rbp)
    movq %rcx, -3488(%rbp)
    callq read_int
    movq -3448(%rbp), %rsi
    movq -3456(%rbp), %rdx
    movq -3464(%rbp), %r10
    movq -3472(%rbp), %r9
    movq -3480(%rbp), %r8
    movq -3488(%rbp), %rcx
    movq %rax, %r8
    jmp loop_197

	.align 16
conclusion:
    addq $3520, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3520, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


