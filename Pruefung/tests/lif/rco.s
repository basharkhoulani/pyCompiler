	.align 16
block_136:
    movq %rcx, %rdi
    movq %r10, -2336(%rbp)
    movq %rsi, -2344(%rbp)
    movq %r8, -2352(%rbp)
    movq %rcx, -2360(%rbp)
    movq %rdx, -2368(%rbp)
    movq %r9, -2376(%rbp)
    callq print_int
    movq -2336(%rbp), %r10
    movq -2344(%rbp), %rsi
    movq -2352(%rbp), %r8
    movq -2360(%rbp), %rcx
    movq -2368(%rbp), %rdx
    movq -2376(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
block_137:
    movq $1, %rcx
    addq $2, %rcx
    addq $3, %rcx
    jmp block_136

	.align 16
block_138:
    movq $1, %rcx
    negq %rcx
    movq $2, %rdx
    negq %rdx
    addq %rdx, %rcx
    movq $3, %rdx
    negq %rdx
    addq %rdx, %rcx
    jmp block_136

	.align 16
start:
    movq $4, %rcx
    addq $2, %rcx
    cmpq $0, %rcx
    jg block_137
    jmp block_138

	.align 16
conclusion:
    addq $2416, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2416, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


