	.align 16
block_175:
    movq %rcx, %rdi
    movq %r10, -3040(%rbp)
    movq %r8, -3048(%rbp)
    movq %rsi, -3056(%rbp)
    movq %rcx, -3064(%rbp)
    movq %r9, -3072(%rbp)
    movq %rdx, -3080(%rbp)
    callq print_int
    movq -3040(%rbp), %r10
    movq -3048(%rbp), %r8
    movq -3056(%rbp), %rsi
    movq -3064(%rbp), %rcx
    movq -3072(%rbp), %r9
    movq -3080(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_177:
    addq $1, %rcx
    jmp loop_176

	.align 16
loop_176:
    cmpq $10, %rcx
    jl block_177
    jmp block_175

	.align 16
start:
    movq $0, %rcx
    jmp loop_176

	.align 16
conclusion:
    addq $3120, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3120, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


