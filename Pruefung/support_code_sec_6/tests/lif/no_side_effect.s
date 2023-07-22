	.align 16
start:
    movq $1, -1440(%rbp)
    addq $2, -1440(%rbp)
    movq -1440(%rbp), %rax
    movq %rax, -1448(%rbp)
    addq $3, -1448(%rbp)
    movq $0, %rdi
    callq print_int
    movq $5, -1456(%rbp)
    addq $6, -1456(%rbp)
    movq -1456(%rbp), %rax
    movq %rax, -1464(%rbp)
    addq $7, -1464(%rbp)
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1472, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1472, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


