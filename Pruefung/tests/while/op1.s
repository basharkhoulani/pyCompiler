	.align 16
block_226:
    movq %rcx, %rdi
    movq %rsi, -3928(%rbp)
    movq %rdx, -3936(%rbp)
    movq %r10, -3944(%rbp)
    movq %r9, -3952(%rbp)
    movq %r8, -3960(%rbp)
    movq %rcx, -3968(%rbp)
    callq print_int
    movq -3928(%rbp), %rsi
    movq -3936(%rbp), %rdx
    movq -3944(%rbp), %r10
    movq -3952(%rbp), %r9
    movq -3960(%rbp), %r8
    movq -3968(%rbp), %rcx
    movq $0, %rax
    jmp conclusion

	.align 16
block_228:
    addq $1, %rcx
    jmp loop_227

	.align 16
loop_227:
    cmpq $10, %rcx
    jl block_228
    jmp block_226

	.align 16
start:
    movq $0, %rcx
    jmp loop_227

	.align 16
conclusion:
    addq $4000, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4000, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


