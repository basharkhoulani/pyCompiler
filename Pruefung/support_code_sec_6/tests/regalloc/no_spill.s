	.align 16
start:
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    movq %r10, -1880(%rbp)
    movq %r8, -1888(%rbp)
    movq %rsi, -1896(%rbp)
    movq %rcx, -1904(%rbp)
    movq %r9, -1912(%rbp)
    movq %rdx, -1920(%rbp)
    callq print_int
    movq -1880(%rbp), %r10
    movq -1888(%rbp), %r8
    movq -1896(%rbp), %rsi
    movq -1904(%rbp), %rcx
    movq -1912(%rbp), %r9
    movq -1920(%rbp), %rdx
    movq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    movq %rcx, %rdi
    movq %r10, -1880(%rbp)
    movq %r8, -1888(%rbp)
    movq %rsi, -1896(%rbp)
    movq %rcx, -1904(%rbp)
    movq %r9, -1912(%rbp)
    movq %rdx, -1920(%rbp)
    callq print_int
    movq -1880(%rbp), %r10
    movq -1888(%rbp), %r8
    movq -1896(%rbp), %rsi
    movq -1904(%rbp), %rcx
    movq -1912(%rbp), %r9
    movq -1920(%rbp), %rdx
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


