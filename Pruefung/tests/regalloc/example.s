	.align 16
start:
    callq read_int
    movq %rax, -1336(%rbp)
    callq read_int
    movq %rax, -1344(%rbp)
    movq -1336(%rbp), %rax
    movq %rax, -1352(%rbp)
    movq -1344(%rbp), %rax
    addq %rax, -1352(%rbp)
    movq -1352(%rbp), %rax
    movq %rax, -1360(%rbp)
    addq $42, -1360(%rbp)
    movq -1360(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1360, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1360, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


