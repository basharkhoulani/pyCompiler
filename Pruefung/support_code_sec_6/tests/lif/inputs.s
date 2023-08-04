	.align 16
block_124:
    movq $0, %rax
    jmp conclusion

	.align 16
block_125:
    movq %rcx, %rdi
    movq %r10, -2320(%rbp)
    movq %r8, -2328(%rbp)
    movq %rsi, -2336(%rbp)
    movq %rcx, -2344(%rbp)
    movq %r9, -2352(%rbp)
    movq %rdx, -2360(%rbp)
    callq print_int
    movq -2320(%rbp), %r10
    movq -2328(%rbp), %r8
    movq -2336(%rbp), %rsi
    movq -2344(%rbp), %rcx
    movq -2352(%rbp), %r9
    movq -2360(%rbp), %rdx
    jmp block_124

	.align 16
block_126:
    movq $1, %rcx
    jmp block_125

	.align 16
block_127:
    movq $42, %rcx
    jmp block_125

	.align 16
block_128:
    movq %r10, -2320(%rbp)
    movq %r8, -2328(%rbp)
    movq %rsi, -2336(%rbp)
    movq %rcx, -2344(%rbp)
    movq %r9, -2352(%rbp)
    movq %rdx, -2360(%rbp)
    callq read_int
    movq -2320(%rbp), %r10
    movq -2328(%rbp), %r8
    movq -2336(%rbp), %rsi
    movq -2344(%rbp), %rcx
    movq -2352(%rbp), %r9
    movq -2360(%rbp), %rdx
    movq %rax, %rcx
    movq $42, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    movq %r10, -2320(%rbp)
    movq %r8, -2328(%rbp)
    movq %rsi, -2336(%rbp)
    movq %rcx, -2344(%rbp)
    movq %r9, -2352(%rbp)
    movq %rdx, -2360(%rbp)
    callq print_int
    movq -2320(%rbp), %r10
    movq -2328(%rbp), %r8
    movq -2336(%rbp), %rsi
    movq -2344(%rbp), %rcx
    movq -2352(%rbp), %r9
    movq -2360(%rbp), %rdx
    jmp block_124

	.align 16
block_129:
    movq %r10, -2320(%rbp)
    movq %r8, -2328(%rbp)
    movq %rsi, -2336(%rbp)
    movq %rcx, -2344(%rbp)
    movq %r9, -2352(%rbp)
    movq %rdx, -2360(%rbp)
    callq read_int
    movq -2320(%rbp), %r10
    movq -2328(%rbp), %r8
    movq -2336(%rbp), %rsi
    movq -2344(%rbp), %rcx
    movq -2352(%rbp), %r9
    movq -2360(%rbp), %rdx
    movq %rax, %rcx
    cmpq $0, %rcx
    je block_126
    jmp block_127

	.align 16
block_130:
    movq %r10, -2320(%rbp)
    movq %r8, -2328(%rbp)
    movq %rsi, -2336(%rbp)
    movq %rcx, -2344(%rbp)
    movq %r9, -2352(%rbp)
    movq %rdx, -2360(%rbp)
    callq read_int
    movq -2320(%rbp), %r10
    movq -2328(%rbp), %r8
    movq -2336(%rbp), %rsi
    movq -2344(%rbp), %rcx
    movq -2352(%rbp), %r9
    movq -2360(%rbp), %rdx
    movq %rax, %rdx
    movq %r10, -2320(%rbp)
    movq %r8, -2328(%rbp)
    movq %rsi, -2336(%rbp)
    movq %rcx, -2344(%rbp)
    movq %r9, -2352(%rbp)
    movq %rdx, -2360(%rbp)
    callq read_int
    movq -2320(%rbp), %r10
    movq -2328(%rbp), %r8
    movq -2336(%rbp), %rsi
    movq -2344(%rbp), %rcx
    movq -2352(%rbp), %r9
    movq -2360(%rbp), %rdx
    movq %rax, %rcx
    cmpq %rcx, %rdx
    jge block_128
    jmp block_129

	.align 16
start:
    movq %r10, -2320(%rbp)
    movq %r8, -2328(%rbp)
    movq %rsi, -2336(%rbp)
    movq %rcx, -2344(%rbp)
    movq %r9, -2352(%rbp)
    movq %rdx, -2360(%rbp)
    callq read_int
    movq -2320(%rbp), %r10
    movq -2328(%rbp), %r8
    movq -2336(%rbp), %rsi
    movq -2344(%rbp), %rcx
    movq -2352(%rbp), %r9
    movq -2360(%rbp), %rdx
    movq %rax, %rdx
    movq %r10, -2320(%rbp)
    movq %r8, -2328(%rbp)
    movq %rsi, -2336(%rbp)
    movq %rcx, -2344(%rbp)
    movq %r9, -2352(%rbp)
    movq %rdx, -2360(%rbp)
    callq read_int
    movq -2320(%rbp), %r10
    movq -2328(%rbp), %r8
    movq -2336(%rbp), %rsi
    movq -2344(%rbp), %rcx
    movq -2352(%rbp), %r9
    movq -2360(%rbp), %rdx
    movq %rax, %rcx
    cmpq %rcx, %rdx
    je block_130
    jmp block_129

	.align 16
conclusion:
    addq $2400, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2400, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


