	.align 16
block_210:
    movq -2000(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_212:
    movq -2008(%rbp), %rax
    addq %rax, -2000(%rbp)
    subq $1, -2008(%rbp)
    jmp loop_211

	.align 16
loop_211:
    cmpq $0, -2008(%rbp)
    jg block_212
    jmp block_210

	.align 16
start:
    movq $0, -2000(%rbp)
    movq $5, -2008(%rbp)
    jmp loop_211

	.align 16
conclusion:
    addq $2016, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2016, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


