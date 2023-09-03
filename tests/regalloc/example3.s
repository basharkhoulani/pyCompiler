	.align 16
start:
    movq %r9, -1048(%rbp)
    movq %rdx, -1056(%rbp)
    movq %rcx, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %r8, -1080(%rbp)
    movq %rsi, -1088(%rbp)
    callq read_int
    movq -1048(%rbp), %r9
    movq -1056(%rbp), %rdx
    movq -1064(%rbp), %rcx
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %r8
    movq -1088(%rbp), %rsi
    movq %rax, %rdx
    movq $1, %rsi
    movq %rdx, %rcx
    addq %rsi, %rcx
    movq %rcx, %rdi
    movq %r9, -1048(%rbp)
    movq %rdx, -1056(%rbp)
    movq %rcx, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %r8, -1080(%rbp)
    movq %rsi, -1088(%rbp)
    callq print_int
    movq -1048(%rbp), %r9
    movq -1056(%rbp), %rdx
    movq -1064(%rbp), %rcx
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %r8
    movq -1088(%rbp), %rsi
    movq %r9, -1048(%rbp)
    movq %rdx, -1056(%rbp)
    movq %rcx, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %r8, -1080(%rbp)
    movq %rsi, -1088(%rbp)
    callq read_int
    movq -1048(%rbp), %r9
    movq -1056(%rbp), %rdx
    movq -1064(%rbp), %rcx
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %r8
    movq -1088(%rbp), %rsi
    movq %rax, %r8
    movq $1, %r9
    movq %rdx, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    movq %rcx, %rdi
    movq %r9, -1048(%rbp)
    movq %rdx, -1056(%rbp)
    movq %rcx, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %r8, -1080(%rbp)
    movq %rsi, -1088(%rbp)
    callq print_int
    movq -1048(%rbp), %r9
    movq -1056(%rbp), %rdx
    movq -1064(%rbp), %rcx
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %r8
    movq -1088(%rbp), %rsi
    movq %r9, -1048(%rbp)
    movq %rdx, -1056(%rbp)
    movq %rcx, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %r8, -1080(%rbp)
    movq %rsi, -1088(%rbp)
    callq read_int
    movq -1048(%rbp), %r9
    movq -1056(%rbp), %rdx
    movq -1064(%rbp), %rcx
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %r8
    movq -1088(%rbp), %rsi
    movq %rax, %rcx
    addq %rsi, %rdx
    addq %r8, %rdx
    addq %r9, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    movq %r9, -1048(%rbp)
    movq %rdx, -1056(%rbp)
    movq %rcx, -1064(%rbp)
    movq %r10, -1072(%rbp)
    movq %r8, -1080(%rbp)
    movq %rsi, -1088(%rbp)
    callq print_int
    movq -1048(%rbp), %r9
    movq -1056(%rbp), %rdx
    movq -1064(%rbp), %rcx
    movq -1072(%rbp), %r10
    movq -1080(%rbp), %r8
    movq -1088(%rbp), %rsi
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1120, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1120, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


