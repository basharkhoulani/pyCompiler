	.align 16
block_231:
    movq -2088(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_233:
    movq -2088(%rbp), %rax
    movq %rax, -2096(%rbp)
    movq -2104(%rbp), %rax
    addq %rax, -2096(%rbp)
    movq -2096(%rbp), %rax
    movq %rax, -2112(%rbp)
    movq -2120(%rbp), %rax
    addq %rax, -2112(%rbp)
    movq -2112(%rbp), %rax
    movq %rax, -2088(%rbp)
    movq -2128(%rbp), %rax
    addq %rax, -2088(%rbp)
    jmp loop_232

	.align 16
loop_232:
    movq -2136(%rbp), %rax
    cmpq %rax, -2088(%rbp)
    jl block_233
    jmp block_231

	.align 16
start:
    movq $1, -2104(%rbp)
    callq read_int
    movq %rax, -2088(%rbp)
    movq $1, -2120(%rbp)
    movq $1, -2128(%rbp)
    callq read_int
    movq %rax, -2136(%rbp)
    jmp loop_232

	.align 16
conclusion:
    addq $2144, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $2144, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


