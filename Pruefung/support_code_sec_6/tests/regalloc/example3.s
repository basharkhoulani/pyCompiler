	.align 16
start:
    callq read_int
    movq %rax, -1240(%rbp)
    movq $1, -1248(%rbp)
    movq -1240(%rbp), %rax
    movq %rax, -1256(%rbp)
    movq -1248(%rbp), %rax
    addq %rax, -1256(%rbp)
    movq -1256(%rbp), %rdi
    callq print_int
    callq read_int
    movq %rax, -1264(%rbp)
    movq $1, -1272(%rbp)
    movq -1240(%rbp), %rax
    movq %rax, -1280(%rbp)
    movq -1264(%rbp), %rax
    addq %rax, -1280(%rbp)
    movq -1280(%rbp), %rax
    movq %rax, -1288(%rbp)
    movq -1272(%rbp), %rax
    addq %rax, -1288(%rbp)
    movq -1288(%rbp), %rdi
    callq print_int
    callq read_int
    movq %rax, -1296(%rbp)
    movq -1240(%rbp), %rax
    movq %rax, -1304(%rbp)
    movq -1248(%rbp), %rax
    addq %rax, -1304(%rbp)
    movq -1304(%rbp), %rax
    movq %rax, -1312(%rbp)
    movq -1264(%rbp), %rax
    addq %rax, -1312(%rbp)
    movq -1312(%rbp), %rax
    movq %rax, -1320(%rbp)
    movq -1272(%rbp), %rax
    addq %rax, -1320(%rbp)
    movq -1320(%rbp), %rax
    movq %rax, -1328(%rbp)
    movq -1296(%rbp), %rax
    addq %rax, -1328(%rbp)
    movq -1328(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1328, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1328, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


