	.align 16
block_138:
    movq $0, %rax
    jmp conclusion

	.align 16
block_139:
    movq $42, %rdi
    movq %r10, -2560(%rbp)
    movq %r8, -2568(%rbp)
    movq %rsi, -2576(%rbp)
    movq %rcx, -2584(%rbp)
    movq %r9, -2592(%rbp)
    movq %rdx, -2600(%rbp)
    callq print_int
    movq -2560(%rbp), %r10
    movq -2568(%rbp), %r8
    movq -2576(%rbp), %rsi
    movq -2584(%rbp), %rcx
    movq -2592(%rbp), %r9
    movq -2600(%rbp), %rdx
    jmp block_138

	.align 16
block_140:
    movq $0, %rdi
    movq %r10, -2560(%rbp)
    movq %r8, -2568(%rbp)
    movq %rsi, -2576(%rbp)
    movq %rcx, -2584(%rbp)
    movq %r9, -2592(%rbp)
    movq %rdx, -2600(%rbp)
    callq print_int
    movq -2560(%rbp), %r10
    movq -2568(%rbp), %r8
    movq -2576(%rbp), %rsi
    movq -2584(%rbp), %rcx
    movq -2592(%rbp), %r9
    movq -2600(%rbp), %rdx
    jmp block_138

	.align 16
block_141:
    addq %rdx, %rcx
    cmpq $2, %rcx
    jg block_139
    jmp block_140

	.align 16
block_142:
    movq $0, %rdi
    movq %r10, -2560(%rbp)
    movq %r8, -2568(%rbp)
    movq %rsi, -2576(%rbp)
    movq %rcx, -2584(%rbp)
    movq %r9, -2592(%rbp)
    movq %rdx, -2600(%rbp)
    callq print_int
    movq -2560(%rbp), %r10
    movq -2568(%rbp), %r8
    movq -2576(%rbp), %rsi
    movq -2584(%rbp), %rcx
    movq -2592(%rbp), %r9
    movq -2600(%rbp), %rdx
    jmp block_138

	.align 16
block_143:
    cmpq $1, %rdx
    jg block_141
    jmp block_142

	.align 16
block_144:
    movq $0, %rdi
    movq %r10, -2560(%rbp)
    movq %r8, -2568(%rbp)
    movq %rsi, -2576(%rbp)
    movq %rcx, -2584(%rbp)
    movq %r9, -2592(%rbp)
    movq %rdx, -2600(%rbp)
    callq print_int
    movq -2560(%rbp), %r10
    movq -2568(%rbp), %r8
    movq -2576(%rbp), %rsi
    movq -2584(%rbp), %rcx
    movq -2592(%rbp), %r9
    movq -2600(%rbp), %rdx
    jmp block_138

	.align 16
block_145:
    cmpq $1, %rcx
    jge block_143
    jmp block_144

	.align 16
block_146:
    movq $0, %rdi
    movq %r10, -2560(%rbp)
    movq %r8, -2568(%rbp)
    movq %rsi, -2576(%rbp)
    movq %rcx, -2584(%rbp)
    movq %r9, -2592(%rbp)
    movq %rdx, -2600(%rbp)
    callq print_int
    movq -2560(%rbp), %r10
    movq -2568(%rbp), %r8
    movq -2576(%rbp), %rsi
    movq -2584(%rbp), %rcx
    movq -2592(%rbp), %r9
    movq -2600(%rbp), %rdx
    jmp block_138

	.align 16
block_147:
    cmpq $0, %rdx
    jg block_145
    jmp block_146

	.align 16
block_148:
    movq $0, %rdi
    movq %r10, -2560(%rbp)
    movq %r8, -2568(%rbp)
    movq %rsi, -2576(%rbp)
    movq %rcx, -2584(%rbp)
    movq %r9, -2592(%rbp)
    movq %rdx, -2600(%rbp)
    callq print_int
    movq -2560(%rbp), %r10
    movq -2568(%rbp), %r8
    movq -2576(%rbp), %rsi
    movq -2584(%rbp), %rcx
    movq -2592(%rbp), %r9
    movq -2600(%rbp), %rdx
    jmp block_138

	.align 16
start:
    movq %r10, -2560(%rbp)
    movq %r8, -2568(%rbp)
    movq %rsi, -2576(%rbp)
    movq %rcx, -2584(%rbp)
    movq %r9, -2592(%rbp)
    movq %rdx, -2600(%rbp)
    callq read_int
    movq -2560(%rbp), %r10
    movq -2568(%rbp), %r8
    movq -2576(%rbp), %rsi
    movq -2584(%rbp), %rcx
    movq -2592(%rbp), %r9
    movq -2600(%rbp), %rdx
    movq %rax, %rcx
    movq %r10, -2560(%rbp)
    movq %r8, -2568(%rbp)
    movq %rsi, -2576(%rbp)
    movq %rcx, -2584(%rbp)
    movq %r9, -2592(%rbp)
    movq %rdx, -2600(%rbp)
    callq read_int
    movq -2560(%rbp), %r10
    movq -2568(%rbp), %r8
    movq -2576(%rbp), %rsi
    movq -2584(%rbp), %rcx
    movq -2592(%rbp), %r9
    movq -2600(%rbp), %rdx
    movq %rax, %rdx
    cmpq $0, %rcx
    jg block_147
    jmp block_148

	.align 16
conclusion:
    addq $2640, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2640, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


