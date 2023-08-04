	.align 16
block_234:
    movq %rcx, %rdi
    movq %r10, -4080(%rbp)
    movq %r8, -4088(%rbp)
    movq %rsi, -4096(%rbp)
    movq %rcx, -4104(%rbp)
    movq %r9, -4112(%rbp)
    movq %rdx, -4120(%rbp)
    callq print_int
    movq -4080(%rbp), %r10
    movq -4088(%rbp), %r8
    movq -4096(%rbp), %rsi
    movq -4104(%rbp), %rcx
    movq -4112(%rbp), %r9
    movq -4120(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_236:
    subq $1, %rcx
    jmp loop_235

	.align 16
loop_235:
    cmpq $0, %rcx
    jg block_236
    jmp block_234

	.align 16
start:
    movq $10, %rcx
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


