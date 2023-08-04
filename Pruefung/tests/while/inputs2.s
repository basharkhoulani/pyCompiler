	.align 16
block_234:
    movq %rcx, %rdi
    movq %r9, -4080(%rbp)
    movq %rdx, -4088(%rbp)
    movq %rcx, -4096(%rbp)
    movq %r10, -4104(%rbp)
    movq %r8, -4112(%rbp)
    movq %rsi, -4120(%rbp)
    callq print_int
    movq -4080(%rbp), %r9
    movq -4088(%rbp), %rdx
    movq -4096(%rbp), %rcx
    movq -4104(%rbp), %r10
    movq -4112(%rbp), %r8
    movq -4120(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
block_236:
    addq %rdx, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    jmp loop_235

	.align 16
loop_235:
    cmpq %rsi, %rcx
    jl block_236
    jmp block_234

	.align 16
start:
    movq $1, %rdx
    movq %r9, -4080(%rbp)
    movq %rdx, -4088(%rbp)
    movq %rcx, -4096(%rbp)
    movq %r10, -4104(%rbp)
    movq %r8, -4112(%rbp)
    movq %rsi, -4120(%rbp)
    callq read_int
    movq -4080(%rbp), %r9
    movq -4088(%rbp), %rdx
    movq -4096(%rbp), %rcx
    movq -4104(%rbp), %r10
    movq -4112(%rbp), %r8
    movq -4120(%rbp), %rsi
    movq %rax, %rcx
    movq $1, %r8
    movq $1, %r9
    movq %r9, -4080(%rbp)
    movq %rdx, -4088(%rbp)
    movq %rcx, -4096(%rbp)
    movq %r10, -4104(%rbp)
    movq %r8, -4112(%rbp)
    movq %rsi, -4120(%rbp)
    callq read_int
    movq -4080(%rbp), %r9
    movq -4088(%rbp), %rdx
    movq -4096(%rbp), %rcx
    movq -4104(%rbp), %r10
    movq -4112(%rbp), %r8
    movq -4120(%rbp), %rsi
    movq %rax, %rsi
    jmp loop_235

	.align 16
conclusion:
    addq $4160, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $4160, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


