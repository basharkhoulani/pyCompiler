	.align 16
block_196:
    movq %rsi, %rdi
    movq %r10, -3456(%rbp)
    movq %rsi, -3464(%rbp)
    movq %r8, -3472(%rbp)
    movq %rcx, -3480(%rbp)
    movq %rdx, -3488(%rbp)
    movq %r9, -3496(%rbp)
    callq print_int
    movq -3456(%rbp), %r10
    movq -3464(%rbp), %rsi
    movq -3472(%rbp), %r8
    movq -3480(%rbp), %rcx
    movq -3488(%rbp), %rdx
    movq -3496(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
block_198:
    movq %r8, %rsi
    addq %rsi, %r8
    addq $1, %rdx
    jmp loop_197

	.align 16
loop_197:
    cmpq %rcx, %rdx
    jl block_198
    jmp block_196

	.align 16
start:
    movq $0, %rsi
    movq $1, %r8
    movq $0, %rdx
    movq %r10, -3456(%rbp)
    movq %rsi, -3464(%rbp)
    movq %r8, -3472(%rbp)
    movq %rcx, -3480(%rbp)
    movq %rdx, -3488(%rbp)
    movq %r9, -3496(%rbp)
    callq read_int
    movq -3456(%rbp), %r10
    movq -3464(%rbp), %rsi
    movq -3472(%rbp), %r8
    movq -3480(%rbp), %rcx
    movq -3488(%rbp), %rdx
    movq -3496(%rbp), %r9
    movq %rax, %rcx
    jmp loop_197

	.align 16
conclusion:
    addq $3536, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3536, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


