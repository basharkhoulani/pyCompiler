	.align 16
block_234:
    movq %rcx, %rdi
    movq %r10, -4096(%rbp)
    movq %rsi, -4104(%rbp)
    movq %r8, -4112(%rbp)
    movq %rcx, -4120(%rbp)
    movq %rdx, -4128(%rbp)
    movq %r9, -4136(%rbp)
    callq print_int
    movq -4096(%rbp), %r10
    movq -4104(%rbp), %rsi
    movq -4112(%rbp), %r8
    movq -4120(%rbp), %rcx
    movq -4128(%rbp), %rdx
    movq -4136(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
block_236:
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %rdx, %rcx
    jmp loop_235

	.align 16
loop_235:
    cmpq %r9, %rcx
    jl block_236
    jmp block_234

	.align 16
start:
    movq $1, %rsi
    movq %r10, -4096(%rbp)
    movq %rsi, -4104(%rbp)
    movq %r8, -4112(%rbp)
    movq %rcx, -4120(%rbp)
    movq %rdx, -4128(%rbp)
    movq %r9, -4136(%rbp)
    callq read_int
    movq -4096(%rbp), %r10
    movq -4104(%rbp), %rsi
    movq -4112(%rbp), %r8
    movq -4120(%rbp), %rcx
    movq -4128(%rbp), %rdx
    movq -4136(%rbp), %r9
    movq %rax, %rcx
    movq $1, %r8
    movq $1, %rdx
    movq %r10, -4096(%rbp)
    movq %rsi, -4104(%rbp)
    movq %r8, -4112(%rbp)
    movq %rcx, -4120(%rbp)
    movq %rdx, -4128(%rbp)
    movq %r9, -4136(%rbp)
    callq read_int
    movq -4096(%rbp), %r10
    movq -4104(%rbp), %rsi
    movq -4112(%rbp), %r8
    movq -4120(%rbp), %rcx
    movq -4128(%rbp), %rdx
    movq -4136(%rbp), %r9
    movq %rax, %r9
    jmp loop_235

	.align 16
conclusion:
    addq $4176, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4176, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


