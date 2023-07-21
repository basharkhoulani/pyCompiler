	.align 16
block_195:
    movq -1912(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_197:
    movq $5, -1912(%rbp)
    movq -1920(%rbp), %rax
    addq %rax, -1912(%rbp)
    addq $1, -1928(%rbp)
    jmp loop_196

	.align 16
loop_196:
    cmpq $2, -1928(%rbp)
    jl block_197
    jmp block_195

	.align 16
start:
    movq $0, -1912(%rbp)
    callq read_int
    movq %rax, -1920(%rbp)
    movq $0, -1928(%rbp)
    jmp loop_196

	.align 16
conclusion:
    addq $1936, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1936, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


