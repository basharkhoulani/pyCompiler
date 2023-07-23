	.align 16
block_172:
    movq $0, %rax
    jmp conclusion

	.align 16
block_174:
    movq %r8, %rdi
    callq print_int
    movq %r8, %rcx
    addq %r9, %rcx
    movq %r9, %r8
    movq %rcx, %r9
    addq $1, %rdx
    jmp loop_173

	.align 16
loop_173:
    cmpq %rsi, %rdx
    jl block_174
    jmp block_172

	.align 16
start:
    callq read_int
    movq %rax, %rsi
    movq $0, %r8
    movq $1, %r9
    movq $0, %rdx
    jmp loop_173

	.align 16
conclusion:
    addq $352, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $352, %rsp
    jmp start


