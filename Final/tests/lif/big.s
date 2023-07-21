	.align 16
block_110:
    movq $0, %rax
    jmp conclusion

	.align 16
block_111:
    movq $1, -1472(%rbp)
    addq $2, -1472(%rbp)
    movq -1472(%rbp), %rax
    movq %rax, -1480(%rbp)
    addq $3, -1480(%rbp)
    movq -1480(%rbp), %rax
    movq %rax, -1488(%rbp)
    subq $4, -1488(%rbp)
    movq -1488(%rbp), %rdi
    callq print_int
    jmp block_110

	.align 16
block_112:
    movq $1, -1496(%rbp)
    subq $2, -1496(%rbp)
    movq -1496(%rbp), %rax
    movq %rax, -1504(%rbp)
    subq $3, -1504(%rbp)
    movq -1504(%rbp), %rdi
    callq print_int
    jmp block_110

	.align 16
block_113:
    movq -1512(%rbp), %rax
    movq %rax, -1520(%rbp)
    movq -1528(%rbp), %rax
    addq %rax, -1520(%rbp)
    movq -1520(%rbp), %rax
    movq %rax, -1536(%rbp)
    movq -1544(%rbp), %rax
    addq %rax, -1536(%rbp)
    movq -1536(%rbp), %rax
    movq %rax, -1552(%rbp)
    movq -1560(%rbp), %rax
    addq %rax, -1552(%rbp)
    movq -1552(%rbp), %rax
    movq %rax, -1568(%rbp)
    movq -1576(%rbp), %rax
    addq %rax, -1568(%rbp)
    movq -1568(%rbp), %rax
    movq %rax, -1584(%rbp)
    movq -1592(%rbp), %rax
    addq %rax, -1584(%rbp)
    movq -1584(%rbp), %rax
    movq %rax, -1600(%rbp)
    movq -1608(%rbp), %rax
    addq %rax, -1600(%rbp)
    movq -1600(%rbp), %rax
    movq %rax, -1616(%rbp)
    movq -1624(%rbp), %rax
    addq %rax, -1616(%rbp)
    movq -1616(%rbp), %rax
    movq %rax, -1632(%rbp)
    movq -1640(%rbp), %rax
    addq %rax, -1632(%rbp)
    movq -1632(%rbp), %rax
    movq %rax, -1648(%rbp)
    movq -1656(%rbp), %rax
    addq %rax, -1648(%rbp)
    movq -1648(%rbp), %rax
    movq %rax, -1664(%rbp)
    movq -1672(%rbp), %rax
    addq %rax, -1664(%rbp)
    movq -1664(%rbp), %rdi
    callq print_int
    jmp block_110

	.align 16
block_114:
    movq $10, -1672(%rbp)
    negq -1672(%rbp)
    jmp block_113

	.align 16
block_115:
    movq $10, -1672(%rbp)
    jmp block_113

	.align 16
block_116:
    cmpq $1, -1680(%rbp)
    je block_111
    jmp block_112

	.align 16
block_117:
    movq $1, -1512(%rbp)
    movq $1, -1528(%rbp)
    movq $1, -1544(%rbp)
    movq $1, -1560(%rbp)
    movq $1, -1576(%rbp)
    movq $1, -1592(%rbp)
    movq $1, -1608(%rbp)
    movq $1, -1624(%rbp)
    movq $1, -1640(%rbp)
    movq $1, -1656(%rbp)
    cmpq $1, -1688(%rbp)
    je block_114
    jmp block_115

	.align 16
start:
    callq read_int
    movq %rax, -1688(%rbp)
    callq read_int
    movq %rax, -1680(%rbp)
    cmpq $0, -1688(%rbp)
    je block_116
    jmp block_117

	.align 16
conclusion:
    addq $1696, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1696, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


