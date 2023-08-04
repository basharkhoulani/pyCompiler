	.align 16
block_209:
    movq %rcx, %rdi
    movq %r10, -3520(%rbp)
    movq %r8, -3528(%rbp)
    movq %rsi, -3536(%rbp)
    movq %rcx, -3544(%rbp)
    movq %r9, -3552(%rbp)
    movq %rdx, -3560(%rbp)
    callq print_int
    movq -3520(%rbp), %r10
    movq -3528(%rbp), %r8
    movq -3536(%rbp), %rsi
    movq -3544(%rbp), %rcx
    movq -3552(%rbp), %r9
    movq -3560(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_211:
    addq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    jmp loop_210

	.align 16
loop_210:
    cmpq %r9, %rcx
    jl block_211
    jmp block_209

	.align 16
start:
    movq $1, %rdx
    movq %r10, -3520(%rbp)
    movq %r8, -3528(%rbp)
    movq %rsi, -3536(%rbp)
    movq %rcx, -3544(%rbp)
    movq %r9, -3552(%rbp)
    movq %rdx, -3560(%rbp)
    callq read_int
    movq -3520(%rbp), %r10
    movq -3528(%rbp), %r8
    movq -3536(%rbp), %rsi
    movq -3544(%rbp), %rcx
    movq -3552(%rbp), %r9
    movq -3560(%rbp), %rdx
    movq %rax, %rcx
    movq $1, %rsi
    movq $1, %r8
    movq %r10, -3520(%rbp)
    movq %r8, -3528(%rbp)
    movq %rsi, -3536(%rbp)
    movq %rcx, -3544(%rbp)
    movq %r9, -3552(%rbp)
    movq %rdx, -3560(%rbp)
    callq read_int
    movq -3520(%rbp), %r10
    movq -3528(%rbp), %r8
    movq -3536(%rbp), %rsi
    movq -3544(%rbp), %rcx
    movq -3552(%rbp), %r9
    movq -3560(%rbp), %rdx
    movq %rax, %r9
    jmp loop_210

	.align 16
conclusion:
    addq $3600, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3600, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


