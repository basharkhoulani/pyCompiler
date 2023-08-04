	.align 16
start:
    movq %r10, -1720(%rbp)
    movq %rsi, -1728(%rbp)
    movq %r8, -1736(%rbp)
    movq %rcx, -1744(%rbp)
    movq %rdx, -1752(%rbp)
    movq %r9, -1760(%rbp)
    callq read_int
    movq -1720(%rbp), %r10
    movq -1728(%rbp), %rsi
    movq -1736(%rbp), %r8
    movq -1744(%rbp), %rcx
    movq -1752(%rbp), %rdx
    movq -1760(%rbp), %r9
    movq %rax, %rcx
    movq $1, -1544(%rbp)
    movq $1, -1552(%rbp)
    movq $1, -1560(%rbp)
    movq $1, -1568(%rbp)
    movq $1, -1576(%rbp)
    movq $1, -1584(%rbp)
    movq $1, -1592(%rbp)
    movq $1, -1600(%rbp)
    movq %r10, -1720(%rbp)
    movq %rsi, -1728(%rbp)
    movq %r8, -1736(%rbp)
    movq %rcx, -1744(%rbp)
    movq %rdx, -1752(%rbp)
    movq %r9, -1760(%rbp)
    callq read_int
    movq -1720(%rbp), %r10
    movq -1728(%rbp), %rsi
    movq -1736(%rbp), %r8
    movq -1744(%rbp), %rcx
    movq -1752(%rbp), %rdx
    movq -1760(%rbp), %r9
    movq %rax, -1608(%rbp)
    movq $1, -1616(%rbp)
    movq $1, -1624(%rbp)
    movq $1, -1632(%rbp)
    movq $1, -1640(%rbp)
    movq $1, -1648(%rbp)
    movq $1, -1656(%rbp)
    movq $1, -1664(%rbp)
    movq $1, -1672(%rbp)
    movq $1, -1680(%rbp)
    movq $1, -1688(%rbp)
    movq $1, -1696(%rbp)
    movq $1, %r10
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq %r10, -1720(%rbp)
    movq %rsi, -1728(%rbp)
    movq %r8, -1736(%rbp)
    movq %rcx, -1744(%rbp)
    movq %rdx, -1752(%rbp)
    movq %r9, -1760(%rbp)
    callq read_int
    movq -1720(%rbp), %r10
    movq -1728(%rbp), %rsi
    movq -1736(%rbp), %r8
    movq -1744(%rbp), %rcx
    movq -1752(%rbp), %rdx
    movq -1760(%rbp), %r9
    movq %rax, %r9
    movq %rcx, -1704(%rbp)
    movq -1544(%rbp), %rax
    addq %rax, -1704(%rbp)
    movq -1704(%rbp), %rax
    movq %rax, -1712(%rbp)
    movq -1552(%rbp), %rax
    addq %rax, -1712(%rbp)
    movq -1712(%rbp), %rdi
    movq %r10, -1720(%rbp)
    movq %rsi, -1728(%rbp)
    movq %r8, -1736(%rbp)
    movq %rcx, -1744(%rbp)
    movq %rdx, -1752(%rbp)
    movq %r9, -1760(%rbp)
    callq print_int
    movq -1720(%rbp), %r10
    movq -1728(%rbp), %rsi
    movq -1736(%rbp), %r8
    movq -1744(%rbp), %rcx
    movq -1752(%rbp), %rdx
    movq -1760(%rbp), %r9
    addq -1544(%rbp), %rcx
    addq -1552(%rbp), %rcx
    addq -1560(%rbp), %rcx
    addq -1568(%rbp), %rcx
    addq -1576(%rbp), %rcx
    addq -1584(%rbp), %rcx
    addq -1592(%rbp), %rcx
    addq -1600(%rbp), %rcx
    addq -1608(%rbp), %rcx
    addq -1616(%rbp), %rcx
    addq -1624(%rbp), %rcx
    addq -1632(%rbp), %rcx
    addq -1640(%rbp), %rcx
    addq -1648(%rbp), %rcx
    addq -1656(%rbp), %rcx
    addq -1664(%rbp), %rcx
    addq -1672(%rbp), %rcx
    addq -1680(%rbp), %rcx
    addq -1688(%rbp), %rcx
    addq -1696(%rbp), %rcx
    addq %r10, %rcx
    addq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    movq %rcx, %rdi
    movq %r10, -1720(%rbp)
    movq %rsi, -1728(%rbp)
    movq %r8, -1736(%rbp)
    movq %rcx, -1744(%rbp)
    movq %rdx, -1752(%rbp)
    movq %r9, -1760(%rbp)
    callq print_int
    movq -1720(%rbp), %r10
    movq -1728(%rbp), %rsi
    movq -1736(%rbp), %r8
    movq -1744(%rbp), %rcx
    movq -1752(%rbp), %rdx
    movq -1760(%rbp), %r9
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1792, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1792, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


