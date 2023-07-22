	.align 16
block_160:
    movq -1816(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_161:
    movq $1, -1824(%rbp)
    addq $2, -1824(%rbp)
    movq -1824(%rbp), %rax
    movq %rax, -1816(%rbp)
    addq $3, -1816(%rbp)
    jmp block_160

	.align 16
block_162:
    movq $1, -1832(%rbp)
    negq -1832(%rbp)
    movq $2, -1840(%rbp)
    negq -1840(%rbp)
    movq -1832(%rbp), %rax
    movq %rax, -1848(%rbp)
    movq -1840(%rbp), %rax
    addq %rax, -1848(%rbp)
    movq $3, -1856(%rbp)
    negq -1856(%rbp)
    movq -1848(%rbp), %rax
    movq %rax, -1816(%rbp)
    movq -1856(%rbp), %rax
    addq %rax, -1816(%rbp)
    jmp block_160

	.align 16
start:
    movq $4, -1864(%rbp)
    addq $2, -1864(%rbp)
    cmpq $0, -1864(%rbp)
    jg block_161
    jmp block_162

	.align 16
conclusion:
    addq $1872, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1872, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


