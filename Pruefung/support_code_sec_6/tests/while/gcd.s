	.align 16
block_193:
    movq %rdx, %rdi
    movq %r10, -3200(%rbp)
    movq %r8, -3208(%rbp)
    movq %rsi, -3216(%rbp)
    movq %rcx, -3224(%rbp)
    movq %r9, -3232(%rbp)
    movq %rdx, -3240(%rbp)
    callq print_int
    movq -3200(%rbp), %r10
    movq -3208(%rbp), %r8
    movq -3216(%rbp), %rsi
    movq -3224(%rbp), %rcx
    movq -3232(%rbp), %r9
    movq -3240(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_195:
    subq %rcx, %rdx
    jmp loop_194

	.align 16
block_196:
    subq %rdx, %rcx
    jmp loop_194

	.align 16
block_197:
    cmpq %rcx, %rdx
    jg block_195
    jmp block_196

	.align 16
loop_194:
    cmpq $0, %rcx
    jne block_197
    jmp block_193

	.align 16
start:
    movq %r10, -3200(%rbp)
    movq %r8, -3208(%rbp)
    movq %rsi, -3216(%rbp)
    movq %rcx, -3224(%rbp)
    movq %r9, -3232(%rbp)
    movq %rdx, -3240(%rbp)
    callq read_int
    movq -3200(%rbp), %r10
    movq -3208(%rbp), %r8
    movq -3216(%rbp), %rsi
    movq -3224(%rbp), %rcx
    movq -3232(%rbp), %r9
    movq -3240(%rbp), %rdx
    movq %rax, %rdx
    movq %r10, -3200(%rbp)
    movq %r8, -3208(%rbp)
    movq %rsi, -3216(%rbp)
    movq %rcx, -3224(%rbp)
    movq %r9, -3232(%rbp)
    movq %rdx, -3240(%rbp)
    callq read_int
    movq -3200(%rbp), %r10
    movq -3208(%rbp), %r8
    movq -3216(%rbp), %rsi
    movq -3224(%rbp), %rcx
    movq -3232(%rbp), %r9
    movq -3240(%rbp), %rdx
    movq %rax, %rcx
    jmp loop_194

	.align 16
conclusion:
    addq $3280, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3280, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


