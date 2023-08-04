	.align 16
block_247:
    movq %rcx, %rdi
    movq %r10, -4160(%rbp)
    movq %r8, -4168(%rbp)
    movq %rsi, -4176(%rbp)
    movq %rcx, -4184(%rbp)
    movq %r9, -4192(%rbp)
    movq %rdx, -4200(%rbp)
    callq print_int
    movq -4160(%rbp), %r10
    movq -4168(%rbp), %r8
    movq -4176(%rbp), %rsi
    movq -4184(%rbp), %rcx
    movq -4192(%rbp), %r9
    movq -4200(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_248:
    movq $42, %rcx
    jmp block_247

	.align 16
block_249:
    movq $0, %rcx
    jmp block_247

	.align 16
block_250:
    cmpq %rcx, %rdx
    sete %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block_248
    jmp block_249

	.align 16
block_251:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rsi, 8(%r11)
    movq %rcx, %r11
    movq %r8, 16(%r11)
    cmpq %rdx, %rdx
    je block_250
    jmp block_249

	.align 16
block_252:
    movq %r15, %rdi
    movq $24, %rsi
    movq %rdx, 0(%r15)
    movq %rdx, -8(%r15)
    movq %rcx, -16(%r15)
    movq %r8, -24(%r15)
    movq %rcx, -32(%r15)
    movq %r10, -4160(%rbp)
    movq %r8, -4168(%rbp)
    movq %rsi, -4176(%rbp)
    movq %rcx, -4184(%rbp)
    movq %r9, -4192(%rbp)
    movq %rdx, -4200(%rbp)
    callq collect
    movq -4160(%rbp), %r10
    movq -4168(%rbp), %r8
    movq -4176(%rbp), %rsi
    movq -4184(%rbp), %rcx
    movq -4192(%rbp), %r9
    movq -4200(%rbp), %rdx
    jmp block_251

	.align 16
block_253:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4, 0(%r11)
    movq %r11, %r8
    movq %r8, %r11
    movq %rcx, 8(%r11)
    movq %r8, %r11
    movq %rdx, 16(%r11)
    movq %r8, %rdx
    movq $3, %rsi
    movq $7, %r8
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_251
    jmp block_252

	.align 16
block_254:
    movq %r15, %rdi
    movq $24, %rsi
    movq %rdx, 0(%r15)
    movq %rdx, -8(%r15)
    movq %rcx, -16(%r15)
    movq %r8, -24(%r15)
    movq %rcx, -32(%r15)
    movq %r10, -4160(%rbp)
    movq %r8, -4168(%rbp)
    movq %rsi, -4176(%rbp)
    movq %rcx, -4184(%rbp)
    movq %r9, -4192(%rbp)
    movq %rdx, -4200(%rbp)
    callq collect
    movq -4160(%rbp), %r10
    movq -4168(%rbp), %r8
    movq -4176(%rbp), %rsi
    movq -4184(%rbp), %rcx
    movq -4192(%rbp), %r9
    movq -4200(%rbp), %rdx
    jmp block_253

	.align 16
start:
    movq $3, %rcx
    movq $7, %rdx
    movq free_ptr(%rip), %rsi
    addq $24, %rsi
    cmpq fromspace_end(%rip), %rsi
    jl block_253
    jmp block_254

	.align 16
conclusion:
    addq $4240, %rsp
    subq $40, %r15
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4240, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    movq $0, 16(%r15)
    movq $0, 24(%r15)
    movq $0, 32(%r15)
    addq $40, %r15
    jmp start


