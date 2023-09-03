	.align 16
block_184:
    movq %rdx, %rdi
    movq %r9, -3200(%rbp)
    movq %rdx, -3208(%rbp)
    movq %rcx, -3216(%rbp)
    movq %r10, -3224(%rbp)
    movq %r8, -3232(%rbp)
    movq %rsi, -3240(%rbp)
    callq print_int
    movq -3200(%rbp), %r9
    movq -3208(%rbp), %rdx
    movq -3216(%rbp), %rcx
    movq -3224(%rbp), %r10
    movq -3232(%rbp), %r8
    movq -3240(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_186:
    addq %rsi, %rdx
    jmp loop_185

	.align 16
loop_185:
    cmpq %rcx, %rdx
    jl block_186
    jmp block_184

	.align 16
start:
    movq %r9, -3200(%rbp)
    movq %rdx, -3208(%rbp)
    movq %rcx, -3216(%rbp)
    movq %r10, -3224(%rbp)
    movq %r8, -3232(%rbp)
    movq %rsi, -3240(%rbp)
    callq read_int
    movq -3200(%rbp), %r9
    movq -3208(%rbp), %rdx
    movq -3216(%rbp), %rcx
    movq -3224(%rbp), %r10
    movq -3232(%rbp), %r8
    movq -3240(%rbp), %rsi
    movq %rax, %rdx
    movq $1, %rsi
    movq %r9, -3200(%rbp)
    movq %rdx, -3208(%rbp)
    movq %rcx, -3216(%rbp)
    movq %r10, -3224(%rbp)
    movq %r8, -3232(%rbp)
    movq %rsi, -3240(%rbp)
    callq read_int
    movq -3200(%rbp), %r9
    movq -3208(%rbp), %rdx
    movq -3216(%rbp), %rcx
    movq -3224(%rbp), %r10
    movq -3232(%rbp), %r8
    movq -3240(%rbp), %rsi
    movq %rax, %rcx
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


