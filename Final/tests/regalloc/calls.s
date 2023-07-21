	.align 16
start:
    movq $1, -1368(%rbp)
    callq read_int
    movq %rax, -1376(%rbp)
    movq $1, -1384(%rbp)
    movq -1368(%rbp), %rax
    movq %rax, -1392(%rbp)
    movq -1384(%rbp), %rax
    addq %rax, -1392(%rbp)
    movq -1392(%rbp), %rax
    movq %rax, -1400(%rbp)
    movq -1376(%rbp), %rax
    addq %rax, -1400(%rbp)
    movq -1400(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1408, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1408, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


