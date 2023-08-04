	.align 16
block_190:
    movq %rdx, %rdi
    movq %r9, -3360(%rbp)
    movq %rdx, -3368(%rbp)
    movq %rcx, -3376(%rbp)
    movq %r10, -3384(%rbp)
    movq %r8, -3392(%rbp)
    movq %rsi, -3400(%rbp)
    callq print_int
    movq -3360(%rbp), %r9
    movq -3368(%rbp), %rdx
    movq -3376(%rbp), %rcx
    movq -3384(%rbp), %r10
    movq -3392(%rbp), %r8
    movq -3400(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_192:
    subq $1, %rdx
    jmp loop_191

	.align 16
block_194:
    subq $1, %rcx
    jmp loop_193

	.align 16
loop_193:
    cmpq $0, %rcx
    jne block_194
    jmp block_192

	.align 16
block_195:
    movq $2, %rcx
    jmp loop_193

	.align 16
loop_191:
    cmpq $0, %rdx
    jg block_195
    jmp block_190

	.align 16
start:
    movq $20, %rdx
    jmp loop_191

	.align 16
conclusion:
    addq $3440, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3440, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


