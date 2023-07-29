	.align 16
start:
    movq $1, %rax
    cmpq $0, %rax
    setg %al
    movzbq %al, %rcx
    movq $1, %rax
    cmpq $0, %rax
    setl %al
    movzbq %al, %rdx
    movq $1, %rax
    cmpq $0, %rax
    setge %al
    movzbq %al, %rsi
    movq $1, %rax
    cmpq $0, %rax
    setle %al
    movzbq %al, %r8
    movq $1, %rax
    cmpq $0, %rax
    sete %al
    movzbq %al, %r9
    movq $1, %rax
    cmpq $0, %rax
    setne %al
    movzbq %al, %r10
    movq %rcx, %rdi
    callq print_int
    movq %rdx, %rdi
    callq print_int
    movq %rsi, %rdi
    callq print_int
    movq %r8, %rdi
    callq print_int
    movq %r9, %rdi
    callq print_int
    movq %r10, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


