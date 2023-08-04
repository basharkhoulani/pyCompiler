	.align 16
block_178:
    movq $0, %rdi
    movq %r10, -3120(%rbp)
    movq %r8, -3128(%rbp)
    movq %rsi, -3136(%rbp)
    movq %rcx, -3144(%rbp)
    movq %r9, -3152(%rbp)
    movq %rdx, -3160(%rbp)
    callq print_int
    movq -3120(%rbp), %r10
    movq -3128(%rbp), %r8
    movq -3136(%rbp), %rsi
    movq -3144(%rbp), %rcx
    movq -3152(%rbp), %r9
    movq -3160(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_179:
    movq $1, %rcx
    jmp block_178

	.align 16
block_180:
    movq $0, %rcx
    jmp block_178

	.align 16
block_181:
    movq $1, %rax
    cmpq $0, %rax
    je block_179
    jmp block_180

	.align 16
block_182:
    movq $1, %rcx
    jmp block_181

	.align 16
block_183:
    movq $0, %rcx
    jmp block_181

	.align 16
block_184:
    movq $1, %rax
    cmpq $0, %rax
    jle block_182
    jmp block_183

	.align 16
block_185:
    movq $1, %rcx
    jmp block_184

	.align 16
block_186:
    movq $0, %rcx
    jmp block_184

	.align 16
block_187:
    movq $1, %rax
    cmpq $0, %rax
    jl block_185
    jmp block_186

	.align 16
block_188:
    movq $1, %rcx
    jmp block_187

	.align 16
block_189:
    movq $0, %rcx
    jmp block_187

	.align 16
block_190:
    movq $0, %rax
    cmpq $1, %rax
    jge block_188
    jmp block_189

	.align 16
block_191:
    movq $1, %rcx
    jmp block_190

	.align 16
block_192:
    movq $0, %rcx
    jmp block_190

	.align 16
start:
    movq $0, %rax
    cmpq $1, %rax
    jg block_191
    jmp block_192

	.align 16
conclusion:
    addq $3200, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3200, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


