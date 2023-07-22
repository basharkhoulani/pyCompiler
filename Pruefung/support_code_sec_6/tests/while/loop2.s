	.align 16
block_225:
    movq $1, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_227:
    movq $0, %rdi
    callq print_int
    jmp loop_226

	.align 16
loop_226:
    movq $1, %rax
    cmpq $2, %rax
    je block_227
    jmp block_225

	.align 16
loop_228:
    jmp loop_226

	.align 16
start:
    jmp loop_228

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


