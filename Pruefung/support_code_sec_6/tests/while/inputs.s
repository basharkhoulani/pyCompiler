	.align 16
block_204:
    movq %rsi, %rdi
    movq %r10, -3440(%rbp)
    movq %r8, -3448(%rbp)
    movq %rsi, -3456(%rbp)
    movq %rcx, -3464(%rbp)
    movq %r9, -3472(%rbp)
    movq %rdx, -3480(%rbp)
    callq print_int
    movq -3440(%rbp), %r10
    movq -3448(%rbp), %r8
    movq -3456(%rbp), %rsi
    movq -3464(%rbp), %rcx
    movq -3472(%rbp), %r9
    movq -3480(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_206:
    addq %rdx, %rsi
    jmp loop_205

	.align 16
loop_205:
    cmpq %rcx, %rsi
    jl block_206
    jmp block_204

	.align 16
start:
    movq %r10, -3440(%rbp)
    movq %r8, -3448(%rbp)
    movq %rsi, -3456(%rbp)
    movq %rcx, -3464(%rbp)
    movq %r9, -3472(%rbp)
    movq %rdx, -3480(%rbp)
    callq read_int
    movq -3440(%rbp), %r10
    movq -3448(%rbp), %r8
    movq -3456(%rbp), %rsi
    movq -3464(%rbp), %rcx
    movq -3472(%rbp), %r9
    movq -3480(%rbp), %rdx
    movq %rax, %rsi
    movq $1, %rdx
    movq %r10, -3440(%rbp)
    movq %r8, -3448(%rbp)
    movq %rsi, -3456(%rbp)
    movq %rcx, -3464(%rbp)
    movq %r9, -3472(%rbp)
    movq %rdx, -3480(%rbp)
    callq read_int
    movq -3440(%rbp), %r10
    movq -3448(%rbp), %r8
    movq -3456(%rbp), %rsi
    movq -3464(%rbp), %rcx
    movq -3472(%rbp), %r9
    movq -3480(%rbp), %rdx
    movq %rax, %rcx
    jmp loop_205

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


