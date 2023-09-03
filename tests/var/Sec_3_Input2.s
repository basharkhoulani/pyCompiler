	.align 16
start:
    movq %r9, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %rcx, -264(%rbp)
    movq %r10, -272(%rbp)
    movq %r8, -280(%rbp)
    movq %rsi, -288(%rbp)
    callq read_int
    movq -248(%rbp), %r9
    movq -256(%rbp), %rdx
    movq -264(%rbp), %rcx
    movq -272(%rbp), %r10
    movq -280(%rbp), %r8
    movq -288(%rbp), %rsi
    movq %rax, %rcx
    movq %r9, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %rcx, -264(%rbp)
    movq %r10, -272(%rbp)
    movq %r8, -280(%rbp)
    movq %rsi, -288(%rbp)
    callq read_int
    movq -248(%rbp), %r9
    movq -256(%rbp), %rdx
    movq -264(%rbp), %rcx
    movq -272(%rbp), %r10
    movq -280(%rbp), %r8
    movq -288(%rbp), %rsi
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %r9, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %rcx, -264(%rbp)
    movq %r10, -272(%rbp)
    movq %r8, -280(%rbp)
    movq %rsi, -288(%rbp)
    callq read_int
    movq -248(%rbp), %r9
    movq -256(%rbp), %rdx
    movq -264(%rbp), %rcx
    movq -272(%rbp), %r10
    movq -280(%rbp), %r8
    movq -288(%rbp), %rsi
    movq %rax, %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    movq %r9, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %rcx, -264(%rbp)
    movq %r10, -272(%rbp)
    movq %r8, -280(%rbp)
    movq %rsi, -288(%rbp)
    callq print_int
    movq -248(%rbp), %r9
    movq -256(%rbp), %rdx
    movq -264(%rbp), %rcx
    movq -272(%rbp), %r10
    movq -280(%rbp), %r8
    movq -288(%rbp), %rsi
    movq %rcx, %rdi
    movq %r9, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %rcx, -264(%rbp)
    movq %r10, -272(%rbp)
    movq %r8, -280(%rbp)
    movq %rsi, -288(%rbp)
    callq print_int
    movq -248(%rbp), %r9
    movq -256(%rbp), %rdx
    movq -264(%rbp), %rcx
    movq -272(%rbp), %r10
    movq -280(%rbp), %r8
    movq -288(%rbp), %rsi
    movq %rcx, %rdi
    movq %r9, -248(%rbp)
    movq %rdx, -256(%rbp)
    movq %rcx, -264(%rbp)
    movq %r10, -272(%rbp)
    movq %r8, -280(%rbp)
    movq %rsi, -288(%rbp)
    callq print_int
    movq -248(%rbp), %r9
    movq -256(%rbp), %rdx
    movq -264(%rbp), %rcx
    movq -272(%rbp), %r10
    movq -280(%rbp), %r8
    movq -288(%rbp), %rsi
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


