	.align 16
block_175:
    movq -1888(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_177:
    movq -1896(%rbp), %rax
    subq %rax, -1888(%rbp)
    jmp loop_176

	.align 16
block_178:
    movq -1888(%rbp), %rax
    subq %rax, -1896(%rbp)
    jmp loop_176

	.align 16
block_179:
    movq -1896(%rbp), %rax
    cmpq %rax, -1888(%rbp)
    jg block_177
    jmp block_178

	.align 16
loop_176:
    cmpq $0, -1896(%rbp)
    jne block_179
    jmp block_175

	.align 16
start:
    callq read_int
    movq %rax, -1888(%rbp)
    callq read_int
    movq %rax, -1896(%rbp)
    jmp loop_176

	.align 16
conclusion:
    addq $1904, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1904, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


