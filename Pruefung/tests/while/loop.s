	.align 16
block_196:
    movq %rcx, %rdi
    movq %r9, -3440(%rbp)
    movq %rdx, -3448(%rbp)
    movq %rcx, -3456(%rbp)
    movq %r10, -3464(%rbp)
    movq %r8, -3472(%rbp)
    movq %rsi, -3480(%rbp)
    callq print_int
    movq -3440(%rbp), %r9
    movq -3448(%rbp), %rdx
    movq -3456(%rbp), %rcx
    movq -3464(%rbp), %r10
    movq -3472(%rbp), %r8
    movq -3480(%rbp), %rsi
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
    movq %r9, -3440(%rbp)
    movq %rdx, -3448(%rbp)
    movq %rcx, -3456(%rbp)
    movq %r10, -3464(%rbp)
    movq %r8, -3472(%rbp)
    movq %rsi, -3480(%rbp)
    callq read_int
    movq -3440(%rbp), %r9
    movq -3448(%rbp), %rdx
    movq -3456(%rbp), %rcx
    movq -3464(%rbp), %r10
    movq -3472(%rbp), %r8
    movq -3480(%rbp), %rsi
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


