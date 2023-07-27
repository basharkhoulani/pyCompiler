	.align 16
start:
    movq $1, -1408(%rbp)
    movq $0, -1416(%rbp)
    movq -1408(%rbp), %rdi
    callq print_int
    movq -1416(%rbp), %rdi
    callq print_int
    movq $2, -1424(%rbp)
    movq -1408(%rbp), %rax
    movq %rax, -1432(%rbp)
    movq -1424(%rbp), %rax
    addq %rax, -1432(%rbp)
    movq -1432(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1440, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1440, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


