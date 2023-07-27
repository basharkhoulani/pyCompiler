	.align 16
block_201:
    movq -1944(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_203:
    subq $1, -1944(%rbp)
    jmp loop_202

	.align 16
loop_202:
    cmpq $1, -1944(%rbp)
    jge block_203
    jmp block_201

	.align 16
start:
    movq $10, -1944(%rbp)
    jmp loop_202

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


