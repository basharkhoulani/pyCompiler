	.align 16
block_169:
    movq -1872(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_171:
    subq $1, -1872(%rbp)
    jmp loop_170

	.align 16
block_173:
    subq $1, -1880(%rbp)
    jmp loop_172

	.align 16
loop_172:
    cmpq $0, -1880(%rbp)
    jne block_173
    jmp block_171

	.align 16
block_174:
    movq $2, -1880(%rbp)
    jmp loop_172

	.align 16
loop_170:
    cmpq $0, -1872(%rbp)
    jg block_174
    jmp block_169

	.align 16
start:
    movq $20, -1872(%rbp)
    jmp loop_170

	.align 16
conclusion:
    addq $1888, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1888, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


