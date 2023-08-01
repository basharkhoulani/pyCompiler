	.align 16
block_283:
    movq %rcx, %rdi
    movq %rsi, -4408(%rbp)
    movq %rdx, -4416(%rbp)
    movq %r10, -4424(%rbp)
    movq %r9, -4432(%rbp)
    movq %r8, -4440(%rbp)
    movq %rcx, -4448(%rbp)
    callq print_int
    movq -4408(%rbp), %rsi
    movq -4416(%rbp), %rdx
    movq -4424(%rbp), %r10
    movq -4432(%rbp), %r9
    movq -4440(%rbp), %r8
    movq -4448(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
block_284:
    movq $42, %rcx
    jmp block_283

	.align 16
block_285:
    movq $0, %rcx
    jmp block_283

	.align 16
block_286:
    cmpq %rcx, %rsi
    sete %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block_284
    jmp block_285

	.align 16
block_287:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rdx, 8(%r11)
    movq %rcx, %r11
    movq %r8, 16(%r11)
    cmpq %rsi, %rsi
    je block_286
    jmp block_285

	.align 16
block_288:
    movq %r15, %rdi
    movq $24, %rsi
    movq %rsi, 0(%r15)
    movq %rsi, -8(%r15)
    movq %rcx, -16(%r15)
    movq %rsi, -24(%r15)
    movq %rcx, -32(%r15)
    movq %rsi, -4408(%rbp)
    movq %rdx, -4416(%rbp)
    movq %r10, -4424(%rbp)
    movq %r9, -4432(%rbp)
    movq %r8, -4440(%rbp)
    movq %rcx, -4448(%rbp)
    callq collect
    movq -4408(%rbp), %rsi
    movq -4416(%rbp), %rdx
    movq -4424(%rbp), %r10
    movq -4432(%rbp), %r9
    movq -4440(%rbp), %r8
    movq -4448(%rbp), %rcx
    jmp block_287

	.align 16
block_289:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4, 0(%r11)
    movq %r11, %rsi
    movq %rsi, %r11
    movq %rdx, 8(%r11)
    movq %rsi, %r11
    movq %rcx, 16(%r11)
    movq $3, %rdx
    movq $7, %r8
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_287
    jmp block_288

	.align 16
block_290:
    movq %r15, %rdi
    movq $24, %rsi
    movq %rsi, 0(%r15)
    movq %rsi, -8(%r15)
    movq %rcx, -16(%r15)
    movq %rsi, -24(%r15)
    movq %rcx, -32(%r15)
    movq %rsi, -4408(%rbp)
    movq %rdx, -4416(%rbp)
    movq %r10, -4424(%rbp)
    movq %r9, -4432(%rbp)
    movq %r8, -4440(%rbp)
    movq %rcx, -4448(%rbp)
    callq collect
    movq -4408(%rbp), %rsi
    movq -4416(%rbp), %rdx
    movq -4424(%rbp), %r10
    movq -4432(%rbp), %r9
    movq -4440(%rbp), %r8
    movq -4448(%rbp), %rcx
    jmp block_289

	.align 16
start:
    movq $3, %rdx
    movq $7, %rcx
    movq free_ptr(%rip), %rsi
    addq $24, %rsi
    cmpq fromspace_end(%rip), %rsi
    jl block_289
    jmp block_290

	.align 16
conclusion:
    addq $4480, %rsp
    subq $40, %r15
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4480, %rsp
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


