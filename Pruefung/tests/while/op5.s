	.align 16
block_222:
    movq -2080(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_224:
    subq $1, -2080(%rbp)
    jmp loop_223

	.align 16
loop_223:
    cmpq $0, -2080(%rbp)
    jne block_224
    jmp block_222

	.align 16
start:
    movq $10, -2080(%rbp)
    jmp loop_223

	.align 16
conclusion:
    addq $2080, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2080, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


