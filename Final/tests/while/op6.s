	.align 16
block_216:
    movq $0, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_217:
    movq $1, %rcx
    jmp block_216

	.align 16
block_218:
    movq $0, %rcx
    jmp block_216

	.align 16
block_219:
    movq $1, %rax
    cmpq $0, %rax
    je block_217
    jmp block_218

	.align 16
block_220:
    movq $1, %rcx
    jmp block_219

	.align 16
block_221:
    movq $0, %rcx
    jmp block_219

	.align 16
block_222:
    movq $1, %rax
    cmpq $0, %rax
    jle block_220
    jmp block_221

	.align 16
block_223:
    movq $1, %rcx
    jmp block_222

	.align 16
block_224:
    movq $0, %rcx
    jmp block_222

	.align 16
block_225:
    movq $1, %rax
    cmpq $0, %rax
    jl block_223
    jmp block_224

	.align 16
block_226:
    movq $1, %rcx
    jmp block_225

	.align 16
block_227:
    movq $0, %rcx
    jmp block_225

	.align 16
block_228:
    movq $0, %rax
    cmpq $1, %rax
    jge block_226
    jmp block_227

	.align 16
block_229:
    movq $1, %rcx
    jmp block_228

	.align 16
block_230:
    movq $0, %rcx
    jmp block_228

	.align 16
start:
    movq $0, %rax
    cmpq $1, %rax
    jg block_229
    jmp block_230

	.align 16
conclusion:
    addq $352, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $352, %rsp
    jmp start


