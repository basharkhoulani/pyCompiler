	.align 16
start:
    callq read_int
    movq %rax, %rcx
    movq $1, -8(%rbp)
    movq $1, -16(%rbp)
    movq $1, -24(%rbp)
    movq $1, -32(%rbp)
    movq $1, -40(%rbp)
    movq $1, -48(%rbp)
    movq $1, -56(%rbp)
    movq $1, -64(%rbp)
    callq read_int
    movq %rax, -72(%rbp)
    movq $1, -80(%rbp)
    movq $1, -88(%rbp)
    movq $1, -96(%rbp)
    movq $1, -104(%rbp)
    movq $1, -112(%rbp)
    movq $1, -120(%rbp)
    movq $1, -128(%rbp)
    movq $1, -136(%rbp)
    movq $1, -144(%rbp)
    movq $1, %r15
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq $1, %r9
    movq $1, %r10
    callq read_int
    movq %rax, %r11
    movq %rcx, -152(%rbp)
    movq -8(%rbp), %rax
    addq %rax, -152(%rbp)
    movq -152(%rbp), %rax
    movq %rax, -160(%rbp)
    movq -16(%rbp), %rax
    addq %rax, -160(%rbp)
    movq -160(%rbp), %rdi
    callq print_int
    addq -8(%rbp), %rcx
    addq -16(%rbp), %rcx
    addq -24(%rbp), %rcx
    addq -32(%rbp), %rcx
    addq -40(%rbp), %rcx
    addq -48(%rbp), %rcx
    addq -56(%rbp), %rcx
    addq -64(%rbp), %rcx
    addq -72(%rbp), %rcx
    addq -80(%rbp), %rcx
    addq -88(%rbp), %rcx
    addq -96(%rbp), %rcx
    addq -104(%rbp), %rcx
    addq -112(%rbp), %rcx
    addq -120(%rbp), %rcx
    addq -128(%rbp), %rcx
    addq -136(%rbp), %rcx
    addq -144(%rbp), %rcx
    addq %r15, %rcx
    addq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    addq %r10, %rcx
    addq %r11, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $160, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $160, %rsp
    jmp start


