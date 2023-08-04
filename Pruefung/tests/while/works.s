	.align 16
block_199:
    movq %rdx, %rdi
    movq %r10, -3536(%rbp)
    movq %rsi, -3544(%rbp)
    movq %r8, -3552(%rbp)
    movq %rcx, -3560(%rbp)
    movq %rdx, -3568(%rbp)
    movq %r9, -3576(%rbp)
    callq print_int
    movq -3536(%rbp), %r10
    movq -3544(%rbp), %rsi
    movq -3552(%rbp), %r8
    movq -3560(%rbp), %rcx
    movq -3568(%rbp), %rdx
    movq -3576(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
block_201:
    movq $5, %rdx
    addq %rcx, %rdx
    addq $1, %rsi
    jmp loop_200

	.align 16
loop_200:
    cmpq $2, %rsi
    jl block_201
    jmp block_199

	.align 16
start:
    movq $0, %rdx
    movq %r10, -3536(%rbp)
    movq %rsi, -3544(%rbp)
    movq %r8, -3552(%rbp)
    movq %rcx, -3560(%rbp)
    movq %rdx, -3568(%rbp)
    movq %r9, -3576(%rbp)
    callq read_int
    movq -3536(%rbp), %r10
    movq -3544(%rbp), %rsi
    movq -3552(%rbp), %r8
    movq -3560(%rbp), %rcx
    movq -3568(%rbp), %rdx
    movq -3576(%rbp), %r9
    movq %rax, %rcx
    movq $0, %rsi
    jmp loop_200

	.align 16
conclusion:
    addq $3616, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3616, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


