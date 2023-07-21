	.align 16
block_180:
    movq $0, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_181:
    movq $1, -1904(%rbp)
    jmp block_180

	.align 16
block_182:
    movq $0, -1904(%rbp)
    jmp block_180

	.align 16
block_183:
    movq $1, %rax
    cmpq $0, %rax
    je block_181
    jmp block_182

	.align 16
block_184:
    movq $1, -1904(%rbp)
    jmp block_183

	.align 16
block_185:
    movq $0, -1904(%rbp)
    jmp block_183

	.align 16
block_186:
    movq $1, %rax
    cmpq $0, %rax
    jle block_184
    jmp block_185

	.align 16
block_187:
    movq $1, -1904(%rbp)
    jmp block_186

	.align 16
block_188:
    movq $0, -1904(%rbp)
    jmp block_186

	.align 16
block_189:
    movq $1, %rax
    cmpq $0, %rax
    jl block_187
    jmp block_188

	.align 16
block_190:
    movq $1, -1904(%rbp)
    jmp block_189

	.align 16
block_191:
    movq $0, -1904(%rbp)
    jmp block_189

	.align 16
block_192:
    movq $0, %rax
    cmpq $1, %rax
    jge block_190
    jmp block_191

	.align 16
block_193:
    movq $1, -1904(%rbp)
    jmp block_192

	.align 16
block_194:
    movq $0, -1904(%rbp)
    jmp block_192

	.align 16
start:
    movq $0, %rax
    cmpq $1, %rax
    jg block_193
    jmp block_194

	.align 16
conclusion:
    addq $1904, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1904, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


