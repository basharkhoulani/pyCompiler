	.align 16
block_234:
    movq -2144(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_236:
    addq $1, -2144(%rbp)
    jmp loop_235

	.align 16
loop_235:
    cmpq $10, -2144(%rbp)
    jle block_236
    jmp block_234

	.align 16
start:
    movq $0, -2144(%rbp)
    jmp loop_235

	.align 16
conclusion:
    addq $2144, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2144, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


