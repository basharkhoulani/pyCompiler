	.align 16
start:
    callq read_int
    movq %rax, -104(%rbp)
    movq -104(%rbp), %rdi
    callq print_int
    callq read_int
    movq %rax, -104(%rbp)
    movq -104(%rbp), %rdi
    callq print_int
    callq read_int
    movq %rax, -104(%rbp)
    movq -104(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $112, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $112, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


