	.align 16
block_204:
    movq -1952(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_206:
    subq $1, -1952(%rbp)
    jmp loop_205

	.align 16
loop_205:
    cmpq $0, -1952(%rbp)
    jg block_206
    jmp block_204

	.align 16
start:
    movq $10, -1952(%rbp)
    jmp loop_205

	.align 16
conclusion:
    addq $1952, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1952, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


