	.align 16
start:
    movq $1, %rcx
    movq $1, -1048(%rbp)
    movq $1, -1056(%rbp)
    movq $1, -1064(%rbp)
    movq $1, -1072(%rbp)
    movq $1, -1080(%rbp)
    movq $1, -1088(%rbp)
    movq $1, -1096(%rbp)
    movq $1, -1104(%rbp)
    movq $1, -1112(%rbp)
    movq $1, -1120(%rbp)
    movq $1, -1128(%rbp)
    movq $1, -1136(%rbp)
    movq $1, -1144(%rbp)
    movq $1, -1152(%rbp)
    movq $1, -1160(%rbp)
    movq $1, -1168(%rbp)
    movq $1, -1176(%rbp)
    movq $1, -1184(%rbp)
    movq $1, -1192(%rbp)
    movq $1, -1200(%rbp)
    movq $1, %r10
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq $1, %r9
    movq %rcx, -1208(%rbp)
    movq -1048(%rbp), %rax
    addq %rax, -1208(%rbp)
    movq -1208(%rbp), %rax
    movq %rax, -1216(%rbp)
    movq -1056(%rbp), %rax
    addq %rax, -1216(%rbp)
    movq -1216(%rbp), %rdi
    movq %r10, -1224(%rbp)
    movq %r8, -1232(%rbp)
    movq %rsi, -1240(%rbp)
    movq %rcx, -1248(%rbp)
    movq %r9, -1256(%rbp)
    movq %rdx, -1264(%rbp)
    callq print_int
    movq -1224(%rbp), %r10
    movq -1232(%rbp), %r8
    movq -1240(%rbp), %rsi
    movq -1248(%rbp), %rcx
    movq -1256(%rbp), %r9
    movq -1264(%rbp), %rdx
    addq -1048(%rbp), %rcx
    addq -1056(%rbp), %rcx
    addq -1064(%rbp), %rcx
    addq -1072(%rbp), %rcx
    addq -1080(%rbp), %rcx
    addq -1088(%rbp), %rcx
    addq -1096(%rbp), %rcx
    addq -1104(%rbp), %rcx
    addq -1112(%rbp), %rcx
    addq -1120(%rbp), %rcx
    addq -1128(%rbp), %rcx
    addq -1136(%rbp), %rcx
    addq -1144(%rbp), %rcx
    addq -1152(%rbp), %rcx
    addq -1160(%rbp), %rcx
    addq -1168(%rbp), %rcx
    addq -1176(%rbp), %rcx
    addq -1184(%rbp), %rcx
    addq -1192(%rbp), %rcx
    addq -1200(%rbp), %rcx
    addq %r10, %rcx
    addq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    movq %rcx, %rdi
    movq %r10, -1224(%rbp)
    movq %r8, -1232(%rbp)
    movq %rsi, -1240(%rbp)
    movq %rcx, -1248(%rbp)
    movq %r9, -1256(%rbp)
    movq %rdx, -1264(%rbp)
    callq print_int
    movq -1224(%rbp), %r10
    movq -1232(%rbp), %r8
    movq -1240(%rbp), %rsi
    movq -1248(%rbp), %rcx
    movq -1256(%rbp), %r9
    movq -1264(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1296, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1296, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


