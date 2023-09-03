	.align 16
start:
    movq $1, %rdx
    movq $0, %rcx
    movq %rdx, %rdi
    movq %r9, -1208(%rbp)
    movq %rdx, -1216(%rbp)
    movq %rcx, -1224(%rbp)
    movq %r10, -1232(%rbp)
    movq %r8, -1240(%rbp)
    movq %rsi, -1248(%rbp)
    callq print_int
    movq -1208(%rbp), %r9
    movq -1216(%rbp), %rdx
    movq -1224(%rbp), %rcx
    movq -1232(%rbp), %r10
    movq -1240(%rbp), %r8
    movq -1248(%rbp), %rsi
    movq %rcx, %rdi
    movq %r9, -1208(%rbp)
    movq %rdx, -1216(%rbp)
    movq %rcx, -1224(%rbp)
    movq %r10, -1232(%rbp)
    movq %r8, -1240(%rbp)
    movq %rsi, -1248(%rbp)
    callq print_int
    movq -1208(%rbp), %r9
    movq -1216(%rbp), %rdx
    movq -1224(%rbp), %rcx
    movq -1232(%rbp), %r10
    movq -1240(%rbp), %r8
    movq -1248(%rbp), %rsi
    movq $2, %rcx
    addq %rcx, %rdx
    movq %rdx, %rdi
    movq %r9, -1208(%rbp)
    movq %rdx, -1216(%rbp)
    movq %rcx, -1224(%rbp)
    movq %r10, -1232(%rbp)
    movq %r8, -1240(%rbp)
    movq %rsi, -1248(%rbp)
    callq print_int
    movq -1208(%rbp), %r9
    movq -1216(%rbp), %rdx
    movq -1224(%rbp), %rcx
    movq -1232(%rbp), %r10
    movq -1240(%rbp), %r8
    movq -1248(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1280, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1280, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


