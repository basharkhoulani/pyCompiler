	.align 16
start:
    movq %r10, -248(%rbp)
    movq %rsi, -256(%rbp)
    movq %r8, -264(%rbp)
    movq %rcx, -272(%rbp)
    movq %rdx, -280(%rbp)
    movq %r9, -288(%rbp)
    callq read_int
    movq -248(%rbp), %r10
    movq -256(%rbp), %rsi
    movq -264(%rbp), %r8
    movq -272(%rbp), %rcx
    movq -280(%rbp), %rdx
    movq -288(%rbp), %r9
    movq %rax, %rcx
    movq %r10, -248(%rbp)
    movq %rsi, -256(%rbp)
    movq %r8, -264(%rbp)
    movq %rcx, -272(%rbp)
    movq %rdx, -280(%rbp)
    movq %r9, -288(%rbp)
    callq read_int
    movq -248(%rbp), %r10
    movq -256(%rbp), %rsi
    movq -264(%rbp), %r8
    movq -272(%rbp), %rcx
    movq -280(%rbp), %rdx
    movq -288(%rbp), %r9
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %r10, -248(%rbp)
    movq %rsi, -256(%rbp)
    movq %r8, -264(%rbp)
    movq %rcx, -272(%rbp)
    movq %rdx, -280(%rbp)
    movq %r9, -288(%rbp)
    callq read_int
    movq -248(%rbp), %r10
    movq -256(%rbp), %rsi
    movq -264(%rbp), %r8
    movq -272(%rbp), %rcx
    movq -280(%rbp), %rdx
    movq -288(%rbp), %r9
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %r10, -248(%rbp)
    movq %rsi, -256(%rbp)
    movq %r8, -264(%rbp)
    movq %rcx, -272(%rbp)
    movq %rdx, -280(%rbp)
    movq %r9, -288(%rbp)
    callq print_int
    movq -248(%rbp), %r10
    movq -256(%rbp), %rsi
    movq -264(%rbp), %r8
    movq -272(%rbp), %rcx
    movq -280(%rbp), %rdx
    movq -288(%rbp), %r9
    movq %rcx, %rdi
    movq %r10, -248(%rbp)
    movq %rsi, -256(%rbp)
    movq %r8, -264(%rbp)
    movq %rcx, -272(%rbp)
    movq %rdx, -280(%rbp)
    movq %r9, -288(%rbp)
    callq print_int
    movq -248(%rbp), %r10
    movq -256(%rbp), %rsi
    movq -264(%rbp), %r8
    movq -272(%rbp), %rcx
    movq -280(%rbp), %rdx
    movq -288(%rbp), %r9
    movq %rcx, %rdi
    movq %r10, -248(%rbp)
    movq %rsi, -256(%rbp)
    movq %r8, -264(%rbp)
    movq %rcx, -272(%rbp)
    movq %rdx, -280(%rbp)
    movq %r9, -288(%rbp)
    callq print_int
    movq -248(%rbp), %r10
    movq -256(%rbp), %rsi
    movq -264(%rbp), %r8
    movq -272(%rbp), %rcx
    movq -280(%rbp), %rdx
    movq -288(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $320, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $320, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


