	.align 16
start:
    movq $1, %rcx
    movq $42, %rdx
    addq $7, %rcx
    movq %rcx, %rsi
    addq %rdx, %rsi
    negq %rcx
    movq %rsi, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    movq %r9, -1880(%rbp)
    movq %rdx, -1888(%rbp)
    movq %rcx, -1896(%rbp)
    movq %r10, -1904(%rbp)
    movq %r8, -1912(%rbp)
    movq %rsi, -1920(%rbp)
    callq print_int
    movq -1880(%rbp), %r9
    movq -1888(%rbp), %rdx
    movq -1896(%rbp), %rcx
    movq -1904(%rbp), %r10
    movq -1912(%rbp), %r8
    movq -1920(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1952, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1952, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


