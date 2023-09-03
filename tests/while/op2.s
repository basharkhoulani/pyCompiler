	.align 16
block_202:
    movq %rcx, %rdi
    movq %r9, -3600(%rbp)
    movq %rdx, -3608(%rbp)
    movq %rcx, -3616(%rbp)
    movq %r10, -3624(%rbp)
    movq %r8, -3632(%rbp)
    movq %rsi, -3640(%rbp)
    callq print_int
    movq -3600(%rbp), %r9
    movq -3608(%rbp), %rdx
    movq -3616(%rbp), %rcx
    movq -3624(%rbp), %r10
    movq -3632(%rbp), %r8
    movq -3640(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_204:
    addq $1, %rcx
    jmp loop_203

	.align 16
loop_203:
    cmpq $10, %rcx
    jle block_204
    jmp block_202

	.align 16
start:
    movq $0, %rcx
    jmp loop_203

	.align 16
conclusion:
    addq $3680, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3680, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


