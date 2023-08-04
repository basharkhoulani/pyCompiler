	.align 16
block_245:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $130, 0(%r11)
    movq %r11, %rdx
    movq %rdx, %r11
    movq %rsi, 8(%r11)
    movq %rdx, %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %rdi
    movq %r9, -4160(%rbp)
    movq %rdx, -4168(%rbp)
    movq %rcx, -4176(%rbp)
    movq %r10, -4184(%rbp)
    movq %r8, -4192(%rbp)
    movq %rsi, -4200(%rbp)
    callq print_int
    movq -4160(%rbp), %r9
    movq -4168(%rbp), %rdx
    movq -4176(%rbp), %rcx
    movq -4184(%rbp), %r10
    movq -4192(%rbp), %r8
    movq -4200(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_246:
    movq %r15, %rdi
    movq $16, %rsi
    movq %rdx, 0(%r15)
    movq %rcx, -8(%r15)
    movq %rcx, -16(%r15)
    movq %rsi, -24(%r15)
    movq %rsi, -32(%r15)
    movq %rcx, -40(%r15)
    movq %r9, -4160(%rbp)
    movq %rdx, -4168(%rbp)
    movq %rcx, -4176(%rbp)
    movq %r10, -4184(%rbp)
    movq %r8, -4192(%rbp)
    movq %rsi, -4200(%rbp)
    callq collect
    movq -4160(%rbp), %r9
    movq -4168(%rbp), %rdx
    movq -4176(%rbp), %rcx
    movq -4184(%rbp), %r10
    movq -4192(%rbp), %r8
    movq -4200(%rbp), %rsi
    jmp block_245

	.align 16
block_247:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $2, 0(%r11)
    movq %r11, %rsi
    movq %rsi, %r11
    movq %rdx, 8(%r11)
    movq %rsi, %rcx
    movq %rcx, %rsi
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_245
    jmp block_246

	.align 16
block_248:
    movq %r15, %rdi
    movq $16, %rsi
    movq %rdx, 0(%r15)
    movq %rcx, -8(%r15)
    movq %rcx, -16(%r15)
    movq %rsi, -24(%r15)
    movq %rsi, -32(%r15)
    movq %rcx, -40(%r15)
    movq %r9, -4160(%rbp)
    movq %rdx, -4168(%rbp)
    movq %rcx, -4176(%rbp)
    movq %r10, -4184(%rbp)
    movq %r8, -4192(%rbp)
    movq %rsi, -4200(%rbp)
    callq collect
    movq -4160(%rbp), %r9
    movq -4168(%rbp), %rdx
    movq -4176(%rbp), %rcx
    movq -4184(%rbp), %r10
    movq -4192(%rbp), %r8
    movq -4200(%rbp), %rsi
    jmp block_247

	.align 16
start:
    movq $42, %rdx
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_247
    jmp block_248

	.align 16
conclusion:
    addq $4240, %rsp
    subq $48, %r15
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
    movq $0, 40(%r15)
    addq $48, %r15
    jmp start


