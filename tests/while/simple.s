	.align 16
block_178:
    movq %rcx, %rdi
    movq %r9, -3040(%rbp)
    movq %rdx, -3048(%rbp)
    movq %rcx, -3056(%rbp)
    movq %r10, -3064(%rbp)
    movq %r8, -3072(%rbp)
    movq %rsi, -3080(%rbp)
    callq print_int
    movq -3040(%rbp), %r9
    movq -3048(%rbp), %rdx
    movq -3056(%rbp), %rcx
    movq -3064(%rbp), %r10
    movq -3072(%rbp), %r8
    movq -3080(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_180:
    addq $1, %rcx
    jmp loop_179

	.align 16
loop_179:
    cmpq $10, %rcx
    jl block_180
    jmp block_178

	.align 16
start:
    movq $0, %rcx
    jmp loop_179

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


