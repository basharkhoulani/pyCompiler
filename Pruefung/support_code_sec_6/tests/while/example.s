	.align 16
block_201:
    movq %rcx, %rdi
    movq %r10, -3360(%rbp)
    movq %r8, -3368(%rbp)
    movq %rsi, -3376(%rbp)
    movq %rcx, -3384(%rbp)
    movq %r9, -3392(%rbp)
    movq %rdx, -3400(%rbp)
    callq print_int
    movq -3360(%rbp), %r10
    movq -3368(%rbp), %r8
    movq -3376(%rbp), %rsi
    movq -3384(%rbp), %rcx
    movq -3392(%rbp), %r9
    movq -3400(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_203:
    addq %rdx, %rcx
    subq $1, %rdx
    jmp loop_202

	.align 16
loop_202:
    cmpq $0, %rdx
    jg block_203
    jmp block_201

	.align 16
start:
    movq $0, %rcx
    movq $5, %rdx
    jmp loop_202

	.align 16
conclusion:
    addq $3440, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3440, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


