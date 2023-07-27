	.align 16
block_219:
    movq -2048(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_221:
    movq -2056(%rbp), %rax
    movq %rax, -2048(%rbp)
    movq -2048(%rbp), %rax
    addq %rax, -2056(%rbp)
    addq $1, -2064(%rbp)
    jmp loop_220

	.align 16
loop_220:
    movq -2072(%rbp), %rax
    cmpq %rax, -2064(%rbp)
    jl block_221
    jmp block_219

	.align 16
start:
    movq $0, -2048(%rbp)
    movq $1, -2056(%rbp)
    movq $0, -2064(%rbp)
    callq read_int
    movq %rax, -2072(%rbp)
    jmp loop_220

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


