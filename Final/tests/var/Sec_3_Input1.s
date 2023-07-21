	.align 16
start:
    callq read_int
    movq %rax, -168(%rbp)
    callq read_int
    movq %rax, -176(%rbp)
    movq -168(%rbp), %rax
    movq %rax, -184(%rbp)
    movq -176(%rbp), %rax
    addq %rax, -184(%rbp)
    callq read_int
    movq %rax, -192(%rbp)
    movq -184(%rbp), %rax
    movq %rax, -200(%rbp)
    movq -192(%rbp), %rax
    addq %rax, -200(%rbp)
    movq -200(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $208, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $208, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


