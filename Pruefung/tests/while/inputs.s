	.align 16
block_184:
    movq %rcx, %rdi
    movq %rsi, -3208(%rbp)
    movq %rdx, -3216(%rbp)
    movq %r10, -3224(%rbp)
    movq %r9, -3232(%rbp)
    movq %r8, -3240(%rbp)
    movq %rcx, -3248(%rbp)
    callq print_int
    movq -3208(%rbp), %rsi
    movq -3216(%rbp), %rdx
    movq -3224(%rbp), %r10
    movq -3232(%rbp), %r9
    movq -3240(%rbp), %r8
    movq -3248(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
block_186:
    addq %rdx, %rcx
    jmp loop_185

	.align 16
loop_185:
    cmpq %rsi, %rcx
    jl block_186
    jmp block_184

	.align 16
start:
    movq %rsi, -3208(%rbp)
    movq %rdx, -3216(%rbp)
    movq %r10, -3224(%rbp)
    movq %r9, -3232(%rbp)
    movq %r8, -3240(%rbp)
    movq %rcx, -3248(%rbp)
    callq read_int
    movq -3208(%rbp), %rsi
    movq -3216(%rbp), %rdx
    movq -3224(%rbp), %r10
    movq -3232(%rbp), %r9
    movq -3240(%rbp), %r8
    movq -3248(%rbp), %rcx
    movq %rax, %rcx
    movq $1, %rdx
    movq %rsi, -3208(%rbp)
    movq %rdx, -3216(%rbp)
    movq %r10, -3224(%rbp)
    movq %r9, -3232(%rbp)
    movq %r8, -3240(%rbp)
    movq %rcx, -3248(%rbp)
    callq read_int
    movq -3208(%rbp), %rsi
    movq -3216(%rbp), %rdx
    movq -3224(%rbp), %r10
    movq -3232(%rbp), %r9
    movq -3240(%rbp), %r8
    movq -3248(%rbp), %rcx
    movq %rax, %rsi
    jmp loop_185

	.align 16
conclusion:
    addq $3280, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3280, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


