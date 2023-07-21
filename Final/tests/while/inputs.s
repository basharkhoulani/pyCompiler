	.align 16
block_213:
    movq -2016(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_215:
    movq -2024(%rbp), %rax
    addq %rax, -2016(%rbp)
    jmp loop_214

	.align 16
loop_214:
    movq -2032(%rbp), %rax
    cmpq %rax, -2016(%rbp)
    jl block_215
    jmp block_213

	.align 16
start:
    callq read_int
    movq %rax, -2016(%rbp)
    movq $1, -2024(%rbp)
    callq read_int
    movq %rax, -2032(%rbp)
    jmp loop_214

	.align 16
conclusion:
    addq $2032, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2032, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


