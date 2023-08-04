	.align 16
block_221:
    movq $1, %rdi
    movq %r10, -3760(%rbp)
    movq %r8, -3768(%rbp)
    movq %rsi, -3776(%rbp)
    movq %rcx, -3784(%rbp)
    movq %r9, -3792(%rbp)
    movq %rdx, -3800(%rbp)
    callq print_int
    movq -3760(%rbp), %r10
    movq -3768(%rbp), %r8
    movq -3776(%rbp), %rsi
    movq -3784(%rbp), %rcx
    movq -3792(%rbp), %r9
    movq -3800(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
block_223:
    movq $0, %rdi
    movq %r10, -3760(%rbp)
    movq %r8, -3768(%rbp)
    movq %rsi, -3776(%rbp)
    movq %rcx, -3784(%rbp)
    movq %r9, -3792(%rbp)
    movq %rdx, -3800(%rbp)
    callq print_int
    movq -3760(%rbp), %r10
    movq -3768(%rbp), %r8
    movq -3776(%rbp), %rsi
    movq -3784(%rbp), %rcx
    movq -3792(%rbp), %r9
    movq -3800(%rbp), %rdx
    jmp loop_222

	.align 16
loop_222:
    movq $1, %rax
    cmpq $2, %rax
    je block_223
    jmp block_221

	.align 16
loop_224:
    jmp loop_222

	.align 16
start:
    jmp loop_224

	.align 16
conclusion:
    addq $3840, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $3840, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


