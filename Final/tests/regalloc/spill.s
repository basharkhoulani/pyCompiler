	.align 16
start:
    movq $1, %rcx
    movq $1, -168(%rbp)
    movq $1, -176(%rbp)
    movq $1, -184(%rbp)
    movq $1, -192(%rbp)
    movq $1, -200(%rbp)
    movq $1, -208(%rbp)
    movq $1, -216(%rbp)
    movq $1, -224(%rbp)
    movq $1, -232(%rbp)
    movq $1, -240(%rbp)
    movq $1, -248(%rbp)
    movq $1, -256(%rbp)
    movq $1, -264(%rbp)
    movq $1, -272(%rbp)
    movq $1, -280(%rbp)
    movq $1, -288(%rbp)
    movq $1, -296(%rbp)
    movq $1, -304(%rbp)
    movq $1, %r15
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq $1, %r9
    movq $1, %r10
    movq $1, %r11
    movq %rcx, -312(%rbp)
    movq -168(%rbp), %rax
    addq %rax, -312(%rbp)
    movq -312(%rbp), %rax
    movq %rax, -320(%rbp)
    movq -176(%rbp), %rax
    addq %rax, -320(%rbp)
    movq -320(%rbp), %rdi
    callq print_int
    addq -168(%rbp), %rcx
    addq -176(%rbp), %rcx
    addq -184(%rbp), %rcx
    addq -192(%rbp), %rcx
    addq -200(%rbp), %rcx
    addq -208(%rbp), %rcx
    addq -216(%rbp), %rcx
    addq -224(%rbp), %rcx
    addq -232(%rbp), %rcx
    addq -240(%rbp), %rcx
    addq -248(%rbp), %rcx
    addq -256(%rbp), %rcx
    addq -264(%rbp), %rcx
    addq -272(%rbp), %rcx
    addq -280(%rbp), %rcx
    addq -288(%rbp), %rcx
    addq -296(%rbp), %rcx
    addq -304(%rbp), %rcx
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
    addq $320, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    jmp start


