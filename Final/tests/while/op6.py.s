	.align 16
start:
    movq $0, %rax
    cmpq $1, %rax
    setg %al
    movzbq %al, %rax
    movq %rax, -8(%rbp)
    movq -8(%rbp), %rdi
    callq print_int
    movq $0, %rax
    cmpq $1, %rax
    setge %al
    movzbq %al, %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rdi
    callq print_int
    movq $1, %rax
    cmpq $0, %rax
    setl %al
    movzbq %al, %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rdi
    callq print_int
    movq $1, %rax
    cmpq $0, %rax
    setle %al
    movzbq %al, %rax
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rdi
    callq print_int
    movq $1, %rax
    cmpq $0, %rax
    sete %al
    movzbq %al, %rax
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    jmp start

	.align 16
conclusion:
    addq $48, %rsp
    popq %rbp
    retq 


