	.align 16
block_173:
    movq %rcx, %rdi
    movq %rsi, -2968(%rbp)
    movq %rdx, -2976(%rbp)
    movq %r10, -2984(%rbp)
    movq %r9, -2992(%rbp)
    movq %r8, -3000(%rbp)
    movq %rcx, -3008(%rbp)
    callq print_int
    movq -2968(%rbp), %rsi
    movq -2976(%rbp), %rdx
    movq -2984(%rbp), %r10
    movq -2992(%rbp), %r9
    movq -3000(%rbp), %r8
    movq -3008(%rbp), %rcx
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
    movq %rsi, -2968(%rbp)
    movq %rdx, -2976(%rbp)
    movq %r10, -2984(%rbp)
    movq %r9, -2992(%rbp)
    movq %r8, -3000(%rbp)
    movq %rcx, -3008(%rbp)
    callq read_int
    movq -2968(%rbp), %rsi
    movq -2976(%rbp), %rdx
    movq -2984(%rbp), %r10
    movq -2992(%rbp), %r9
    movq -3000(%rbp), %r8
    movq -3008(%rbp), %rcx
    movq %rax, %rcx
    movq %rsi, -2968(%rbp)
    movq %rdx, -2976(%rbp)
    movq %r10, -2984(%rbp)
    movq %r9, -2992(%rbp)
    movq %r8, -3000(%rbp)
    movq %rcx, -3008(%rbp)
    callq read_int
    movq -2968(%rbp), %rsi
    movq -2976(%rbp), %rdx
    movq -2984(%rbp), %r10
    movq -2992(%rbp), %r9
    movq -3000(%rbp), %r8
    movq -3008(%rbp), %rcx
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


