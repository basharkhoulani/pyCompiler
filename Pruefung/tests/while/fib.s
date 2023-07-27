	.align 16
block_207:
    movq $0, %rax
    jmp conclusion

	.align 16
block_209:
    movq -1960(%rbp), %rdi
    callq print_int
    movq -1960(%rbp), %rax
    movq %rax, -1968(%rbp)
    movq -1976(%rbp), %rax
    addq %rax, -1968(%rbp)
    movq -1976(%rbp), %rax
    movq %rax, -1960(%rbp)
    movq -1968(%rbp), %rax
    movq %rax, -1976(%rbp)
    addq $1, -1984(%rbp)
    jmp loop_208

	.align 16
loop_208:
    movq -1992(%rbp), %rax
    cmpq %rax, -1984(%rbp)
    jl block_209
    jmp block_207

	.align 16
start:
    callq read_int
    movq %rax, -1992(%rbp)
    movq $0, -1960(%rbp)
    movq $1, -1976(%rbp)
    movq $0, -1984(%rbp)
    jmp loop_208

	.align 16
conclusion:
    addq $2000, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2000, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


