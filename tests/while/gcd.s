	.align 16
block_173:
    movq %rcx, %rdi
    movq %r9, -2960(%rbp)
    movq %rdx, -2968(%rbp)
    movq %rcx, -2976(%rbp)
    movq %r10, -2984(%rbp)
    movq %r8, -2992(%rbp)
    movq %rsi, -3000(%rbp)
    callq print_int
    movq -2960(%rbp), %r9
    movq -2968(%rbp), %rdx
    movq -2976(%rbp), %rcx
    movq -2984(%rbp), %r10
    movq -2992(%rbp), %r8
    movq -3000(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_175:
    subq %rdx, %rcx
    jmp loop_174

	.align 16
block_176:
    subq %rcx, %rdx
    jmp loop_174

	.align 16
block_177:
    cmpq %rdx, %rcx
    jg block_175
    jmp block_176

	.align 16
loop_174:
    cmpq $0, %rdx
    jne block_177
    jmp block_173

	.align 16
start:
    movq %r9, -2960(%rbp)
    movq %rdx, -2968(%rbp)
    movq %rcx, -2976(%rbp)
    movq %r10, -2984(%rbp)
    movq %r8, -2992(%rbp)
    movq %rsi, -3000(%rbp)
    callq read_int
    movq -2960(%rbp), %r9
    movq -2968(%rbp), %rdx
    movq -2976(%rbp), %rcx
    movq -2984(%rbp), %r10
    movq -2992(%rbp), %r8
    movq -3000(%rbp), %rsi
    movq %rax, %rcx
    movq %r9, -2960(%rbp)
    movq %rdx, -2968(%rbp)
    movq %rcx, -2976(%rbp)
    movq %r10, -2984(%rbp)
    movq %r8, -2992(%rbp)
    movq %rsi, -3000(%rbp)
    callq read_int
    movq -2960(%rbp), %r9
    movq -2968(%rbp), %rdx
    movq -2976(%rbp), %rcx
    movq -2984(%rbp), %r10
    movq -2992(%rbp), %r8
    movq -3000(%rbp), %rsi
    movq %rax, %rdx
    jmp loop_174

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


