	.align 16
block_181:
    movq %rcx, %rdi
    movq %r10, -3136(%rbp)
    movq %rsi, -3144(%rbp)
    movq %r8, -3152(%rbp)
    movq %rcx, -3160(%rbp)
    movq %rdx, -3168(%rbp)
    movq %r9, -3176(%rbp)
    callq print_int
    movq -3136(%rbp), %r10
    movq -3144(%rbp), %rsi
    movq -3152(%rbp), %r8
    movq -3160(%rbp), %rcx
    movq -3168(%rbp), %rdx
    movq -3176(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
block_183:
    subq $1, %rcx
    jmp loop_182

	.align 16
loop_182:
    cmpq $1, %rcx
    jge block_183
    jmp block_181

	.align 16
start:
    movq $10, %rcx
    jmp loop_182

	.align 16
conclusion:
    addq $3216, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3216, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


