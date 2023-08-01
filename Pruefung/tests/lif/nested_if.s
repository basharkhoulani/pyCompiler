	.align 16
block_155:
    movq $0, %rax
    jmp conclusion

	.align 16
block_156:
    movq $42, %rdi
    movq %rsi, -2728(%rbp)
    movq %rdx, -2736(%rbp)
    movq %r10, -2744(%rbp)
    movq %r9, -2752(%rbp)
    movq %r8, -2760(%rbp)
    movq %rcx, -2768(%rbp)
    callq print_int
    movq -2728(%rbp), %rsi
    movq -2736(%rbp), %rdx
    movq -2744(%rbp), %r10
    movq -2752(%rbp), %r9
    movq -2760(%rbp), %r8
    movq -2768(%rbp), %rcx
    jmp block_155

	.align 16
block_157:
    movq $0, %rdi
    movq %rsi, -2728(%rbp)
    movq %rdx, -2736(%rbp)
    movq %r10, -2744(%rbp)
    movq %r9, -2752(%rbp)
    movq %r8, -2760(%rbp)
    movq %rcx, -2768(%rbp)
    callq print_int
    movq -2728(%rbp), %rsi
    movq -2736(%rbp), %rdx
    movq -2744(%rbp), %r10
    movq -2752(%rbp), %r9
    movq -2760(%rbp), %r8
    movq -2768(%rbp), %rcx
    jmp block_155

	.align 16
block_158:
    addq %rdx, %rcx
    cmpq $2, %rcx
    jg block_156
    jmp block_157

	.align 16
block_159:
    movq $0, %rdi
    movq %rsi, -2728(%rbp)
    movq %rdx, -2736(%rbp)
    movq %r10, -2744(%rbp)
    movq %r9, -2752(%rbp)
    movq %r8, -2760(%rbp)
    movq %rcx, -2768(%rbp)
    callq print_int
    movq -2728(%rbp), %rsi
    movq -2736(%rbp), %rdx
    movq -2744(%rbp), %r10
    movq -2752(%rbp), %r9
    movq -2760(%rbp), %r8
    movq -2768(%rbp), %rcx
    jmp block_155

	.align 16
block_160:
    cmpq $1, %rdx
    jg block_158
    jmp block_159

	.align 16
block_161:
    movq $0, %rdi
    movq %rsi, -2728(%rbp)
    movq %rdx, -2736(%rbp)
    movq %r10, -2744(%rbp)
    movq %r9, -2752(%rbp)
    movq %r8, -2760(%rbp)
    movq %rcx, -2768(%rbp)
    callq print_int
    movq -2728(%rbp), %rsi
    movq -2736(%rbp), %rdx
    movq -2744(%rbp), %r10
    movq -2752(%rbp), %r9
    movq -2760(%rbp), %r8
    movq -2768(%rbp), %rcx
    jmp block_155

	.align 16
block_162:
    cmpq $1, %rcx
    jge block_160
    jmp block_161

	.align 16
block_163:
    movq $0, %rdi
    movq %rsi, -2728(%rbp)
    movq %rdx, -2736(%rbp)
    movq %r10, -2744(%rbp)
    movq %r9, -2752(%rbp)
    movq %r8, -2760(%rbp)
    movq %rcx, -2768(%rbp)
    callq print_int
    movq -2728(%rbp), %rsi
    movq -2736(%rbp), %rdx
    movq -2744(%rbp), %r10
    movq -2752(%rbp), %r9
    movq -2760(%rbp), %r8
    movq -2768(%rbp), %rcx
    jmp block_155

	.align 16
block_164:
    cmpq $0, %rdx
    jg block_162
    jmp block_163

	.align 16
block_165:
    movq $0, %rdi
    movq %rsi, -2728(%rbp)
    movq %rdx, -2736(%rbp)
    movq %r10, -2744(%rbp)
    movq %r9, -2752(%rbp)
    movq %r8, -2760(%rbp)
    movq %rcx, -2768(%rbp)
    callq print_int
    movq -2728(%rbp), %rsi
    movq -2736(%rbp), %rdx
    movq -2744(%rbp), %r10
    movq -2752(%rbp), %r9
    movq -2760(%rbp), %r8
    movq -2768(%rbp), %rcx
    jmp block_155

	.align 16
start:
    movq %rsi, -2728(%rbp)
    movq %rdx, -2736(%rbp)
    movq %r10, -2744(%rbp)
    movq %r9, -2752(%rbp)
    movq %r8, -2760(%rbp)
    movq %rcx, -2768(%rbp)
    callq read_int
    movq -2728(%rbp), %rsi
    movq -2736(%rbp), %rdx
    movq -2744(%rbp), %r10
    movq -2752(%rbp), %r9
    movq -2760(%rbp), %r8
    movq -2768(%rbp), %rcx
    movq %rax, %rcx
    movq %rsi, -2728(%rbp)
    movq %rdx, -2736(%rbp)
    movq %r10, -2744(%rbp)
    movq %r9, -2752(%rbp)
    movq %r8, -2760(%rbp)
    movq %rcx, -2768(%rbp)
    callq read_int
    movq -2728(%rbp), %rsi
    movq -2736(%rbp), %rdx
    movq -2744(%rbp), %r10
    movq -2752(%rbp), %r9
    movq -2760(%rbp), %r8
    movq -2768(%rbp), %rcx
    movq %rax, %rdx
    cmpq $0, %rcx
    jg block_164
    jmp block_165

	.align 16
conclusion:
    addq $2800, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2800, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


