	.align 16
block_205:
    movq $0, %rdi
    movq %r9, -3680(%rbp)
    movq %rdx, -3688(%rbp)
    movq %rcx, -3696(%rbp)
    movq %r10, -3704(%rbp)
    movq %r8, -3712(%rbp)
    movq %rsi, -3720(%rbp)
    callq print_int
    movq -3680(%rbp), %r9
    movq -3688(%rbp), %rdx
    movq -3696(%rbp), %rcx
    movq -3704(%rbp), %r10
    movq -3712(%rbp), %r8
    movq -3720(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_206:
    movq $1, %rcx
    jmp block_205

	.align 16
block_207:
    movq $0, %rcx
    jmp block_205

	.align 16
block_208:
    movq $1, %rax
    cmpq $0, %rax
    je block_206
    jmp block_207

	.align 16
block_209:
    movq $1, %rcx
    jmp block_208

	.align 16
block_210:
    movq $0, %rcx
    jmp block_208

	.align 16
block_211:
    movq $1, %rax
    cmpq $0, %rax
    jle block_209
    jmp block_210

	.align 16
block_212:
    movq $1, %rcx
    jmp block_211

	.align 16
block_213:
    movq $0, %rcx
    jmp block_211

	.align 16
block_214:
    movq $1, %rax
    cmpq $0, %rax
    jl block_212
    jmp block_213

	.align 16
block_215:
    movq $1, %rcx
    jmp block_214

	.align 16
block_216:
    movq $0, %rcx
    jmp block_214

	.align 16
block_217:
    movq $0, %rax
    cmpq $1, %rax
    jge block_215
    jmp block_216

	.align 16
block_218:
    movq $1, %rcx
    jmp block_217

	.align 16
block_219:
    movq $0, %rcx
    jmp block_217

	.align 16
start:
    movq $0, %rax
    cmpq $1, %rax
    jg block_218
    jmp block_219

	.align 16
conclusion:
    addq $3760, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3760, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


