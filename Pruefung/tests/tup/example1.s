	.align 16
block_16:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $2, 0(%r11)
    movq %r11, %rdx
    movq %rdx, %r11
    movq %rsi, 8(%r11)
    movq %rdx, %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %rdi
    movq %r9, -88(%rbp)
    movq %rdx, -96(%rbp)
    movq %r10, -104(%rbp)
    movq %r8, -112(%rbp)
    movq %rcx, -120(%rbp)
    movq %rsi, -128(%rbp)
    callq print_int
    movq -88(%rbp), %r9
    movq -96(%rbp), %rdx
    movq -104(%rbp), %r10
    movq -112(%rbp), %r8
    movq -120(%rbp), %rcx
    movq -128(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_17:
    movq %r15, %rdi
    movq $16, %rsi
    movq %rdx, 0(%r15)
    movq %rcx, -8(%r15)
    movq %r9, -88(%rbp)
    movq %rdx, -96(%rbp)
    movq %r10, -104(%rbp)
    movq %r8, -112(%rbp)
    movq %rcx, -120(%rbp)
    movq %rsi, -128(%rbp)
    callq collect
    movq -88(%rbp), %r9
    movq -96(%rbp), %rdx
    movq -104(%rbp), %r10
    movq -112(%rbp), %r8
    movq -120(%rbp), %rcx
    movq -128(%rbp), %rsi
    jmp block_16

	.align 16
start:
    movq $42, %rsi
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block_16
    jmp block_17

	.align 16
conclusion:
    addq $160, %rsp
    subq $16, %r15
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    addq $16, %r15
    jmp start


