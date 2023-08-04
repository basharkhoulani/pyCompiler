	.align 16
block_212:
    movq %rsi, %rdi
    movq %r10, -3600(%rbp)
    movq %r8, -3608(%rbp)
    movq %rsi, -3616(%rbp)
    movq %rcx, -3624(%rbp)
    movq %r9, -3632(%rbp)
    movq %rdx, -3640(%rbp)
    callq print_int
    movq -3600(%rbp), %r10
    movq -3608(%rbp), %r8
    movq -3616(%rbp), %rsi
    movq -3624(%rbp), %rcx
    movq -3632(%rbp), %r9
    movq -3640(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_214:
    movq %rcx, %rsi
    addq %rsi, %rcx
    addq $1, %r8
    jmp loop_213

	.align 16
loop_213:
    cmpq %rdx, %r8
    jl block_214
    jmp block_212

	.align 16
start:
    movq $0, %rsi
    movq $1, %rcx
    movq $0, %r8
    movq %r10, -3600(%rbp)
    movq %r8, -3608(%rbp)
    movq %rsi, -3616(%rbp)
    movq %rcx, -3624(%rbp)
    movq %r9, -3632(%rbp)
    movq %rdx, -3640(%rbp)
    callq read_int
    movq -3600(%rbp), %r10
    movq -3608(%rbp), %r8
    movq -3616(%rbp), %rsi
    movq -3624(%rbp), %rcx
    movq -3632(%rbp), %r9
    movq -3640(%rbp), %rdx
    movq %rax, %rdx
    jmp loop_213

	.align 16
conclusion:
    addq $3680, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3680, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


