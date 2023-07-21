	.align 16
start:
    movq $1, -768(%rbp)
    movq $1, -776(%rbp)
    movq $1, -784(%rbp)
    movq -768(%rbp), %rax
    movq %rax, -792(%rbp)
    movq -776(%rbp), %rax
    addq %rax, -792(%rbp)
    movq -792(%rbp), %rdi
    callq print_int
    movq -768(%rbp), %rax
    movq %rax, -800(%rbp)
    movq -776(%rbp), %rax
    addq %rax, -800(%rbp)
    movq -800(%rbp), %rax
    movq %rax, -808(%rbp)
    movq -784(%rbp), %rax
    addq %rax, -808(%rbp)
    movq -808(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $816, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $816, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


