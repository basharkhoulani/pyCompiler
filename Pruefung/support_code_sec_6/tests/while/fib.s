	.align 16
block_172:
    movq $0, %rax
    jmp conclusion

	.align 16
block_174:
    movq %r9, %rdi
    movq %r10, -2960(%rbp)
    movq %r8, -2968(%rbp)
    movq %rsi, -2976(%rbp)
    movq %rcx, -2984(%rbp)
    movq %r9, -2992(%rbp)
    movq %rdx, -3000(%rbp)
    callq print_int
    movq -2960(%rbp), %r10
    movq -2968(%rbp), %r8
    movq -2976(%rbp), %rsi
    movq -2984(%rbp), %rcx
    movq -2992(%rbp), %r9
    movq -3000(%rbp), %rdx
    movq %r9, %rcx
    addq %r8, %rcx
    movq %r8, %r9
    movq %rcx, %r8
    addq $1, %rdx
    jmp loop_173

	.align 16
loop_173:
    cmpq %rsi, %rdx
    jl block_174
    jmp block_172

	.align 16
start:
    movq %r10, -2960(%rbp)
    movq %r8, -2968(%rbp)
    movq %rsi, -2976(%rbp)
    movq %rcx, -2984(%rbp)
    movq %r9, -2992(%rbp)
    movq %rdx, -3000(%rbp)
    callq read_int
    movq -2960(%rbp), %r10
    movq -2968(%rbp), %r8
    movq -2976(%rbp), %rsi
    movq -2984(%rbp), %rcx
    movq -2992(%rbp), %r9
    movq -3000(%rbp), %rdx
    movq %rax, %rsi
    movq $0, %r9
    movq $1, %r8
    movq $0, %rdx
    jmp loop_173

	.align 16
conclusion:
    addq $3040, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3040, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


