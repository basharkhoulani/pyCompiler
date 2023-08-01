	.align 16
block_199:
    movq %rcx, %rdi
    movq %rsi, -3528(%rbp)
    movq %rdx, -3536(%rbp)
    movq %r10, -3544(%rbp)
    movq %r9, -3552(%rbp)
    movq %r8, -3560(%rbp)
    movq %rcx, -3568(%rbp)
    callq print_int
    movq -3528(%rbp), %rsi
    movq -3536(%rbp), %rdx
    movq -3544(%rbp), %r10
    movq -3552(%rbp), %r9
    movq -3560(%rbp), %r8
    movq -3568(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
block_201:
    movq $5, %rcx
    addq %rsi, %rcx
    addq $1, %rdx
    jmp loop_200

	.align 16
loop_200:
    cmpq $2, %rdx
    jl block_201
    jmp block_199

	.align 16
start:
    movq $0, %rcx
    movq %rsi, -3528(%rbp)
    movq %rdx, -3536(%rbp)
    movq %r10, -3544(%rbp)
    movq %r9, -3552(%rbp)
    movq %r8, -3560(%rbp)
    movq %rcx, -3568(%rbp)
    callq read_int
    movq -3528(%rbp), %rsi
    movq -3536(%rbp), %rdx
    movq -3544(%rbp), %r10
    movq -3552(%rbp), %r9
    movq -3560(%rbp), %r8
    movq -3568(%rbp), %rcx
    movq %rax, %rsi
    movq $0, %rdx
    jmp loop_200

	.align 16
conclusion:
    addq $3600, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3600, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


