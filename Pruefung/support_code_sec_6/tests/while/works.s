	.align 16
block_231:
    movq %rsi, %rdi
    movq %r10, -4000(%rbp)
    movq %r8, -4008(%rbp)
    movq %rsi, -4016(%rbp)
    movq %rcx, -4024(%rbp)
    movq %r9, -4032(%rbp)
    movq %rdx, -4040(%rbp)
    callq print_int
    movq -4000(%rbp), %r10
    movq -4008(%rbp), %r8
    movq -4016(%rbp), %rsi
    movq -4024(%rbp), %rcx
    movq -4032(%rbp), %r9
    movq -4040(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_233:
    movq $5, %rsi
    addq %rcx, %rsi
    addq $1, %rdx
    jmp loop_232

	.align 16
loop_232:
    cmpq $2, %rdx
    jl block_233
    jmp block_231

	.align 16
start:
    movq $0, %rsi
    movq %r10, -4000(%rbp)
    movq %r8, -4008(%rbp)
    movq %rsi, -4016(%rbp)
    movq %rcx, -4024(%rbp)
    movq %r9, -4032(%rbp)
    movq %rdx, -4040(%rbp)
    callq read_int
    movq -4000(%rbp), %r10
    movq -4008(%rbp), %r8
    movq -4016(%rbp), %rsi
    movq -4024(%rbp), %rcx
    movq -4032(%rbp), %r9
    movq -4040(%rbp), %rdx
    movq %rax, %rcx
    movq $0, %rdx
    jmp loop_232

	.align 16
conclusion:
    addq $4080, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4080, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


