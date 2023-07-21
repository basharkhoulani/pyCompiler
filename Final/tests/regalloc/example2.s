	.align 16
start:
    movq $1, -288(%rbp)
    movq $42, -296(%rbp)
    movq -288(%rbp), %rax
    movq %rax, -304(%rbp)
    addq $7, -304(%rbp)
    movq -304(%rbp), %rax
    movq %rax, -312(%rbp)
    movq -304(%rbp), %rax
    movq %rax, -320(%rbp)
    movq -296(%rbp), %rax
    addq %rax, -320(%rbp)
    movq -312(%rbp), %rax
    movq %rax, -328(%rbp)
    negq -328(%rbp)
    movq -320(%rbp), %rax
    movq %rax, -336(%rbp)
    movq -328(%rbp), %rax
    addq %rax, -336(%rbp)
    movq -336(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $336, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $336, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


