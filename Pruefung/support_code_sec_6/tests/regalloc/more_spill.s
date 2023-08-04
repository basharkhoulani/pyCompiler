	.align 16
start:
    movq %r10, -1480(%rbp)
    movq %r8, -1488(%rbp)
    movq %rsi, -1496(%rbp)
    movq %rcx, -1504(%rbp)
    movq %r9, -1512(%rbp)
    movq %rdx, -1520(%rbp)
    callq read_int
    movq -1480(%rbp), %r10
    movq -1488(%rbp), %r8
    movq -1496(%rbp), %rsi
    movq -1504(%rbp), %rcx
    movq -1512(%rbp), %r9
    movq -1520(%rbp), %rdx
    movq %rax, %rcx
    movq $1, -1304(%rbp)
    movq $1, -1312(%rbp)
    movq $1, -1320(%rbp)
    movq $1, -1328(%rbp)
    movq $1, -1336(%rbp)
    movq $1, -1344(%rbp)
    movq $1, -1352(%rbp)
    movq $1, -1360(%rbp)
    movq %r10, -1480(%rbp)
    movq %r8, -1488(%rbp)
    movq %rsi, -1496(%rbp)
    movq %rcx, -1504(%rbp)
    movq %r9, -1512(%rbp)
    movq %rdx, -1520(%rbp)
    callq read_int
    movq -1480(%rbp), %r10
    movq -1488(%rbp), %r8
    movq -1496(%rbp), %rsi
    movq -1504(%rbp), %rcx
    movq -1512(%rbp), %r9
    movq -1520(%rbp), %rdx
    movq %rax, -1368(%rbp)
    movq $1, -1376(%rbp)
    movq $1, -1384(%rbp)
    movq $1, -1392(%rbp)
    movq $1, -1400(%rbp)
    movq $1, -1408(%rbp)
    movq $1, -1416(%rbp)
    movq $1, -1424(%rbp)
    movq $1, -1432(%rbp)
    movq $1, -1440(%rbp)
    movq $1, -1448(%rbp)
    movq $1, -1456(%rbp)
    movq $1, %r10
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq %r10, -1480(%rbp)
    movq %r8, -1488(%rbp)
    movq %rsi, -1496(%rbp)
    movq %rcx, -1504(%rbp)
    movq %r9, -1512(%rbp)
    movq %rdx, -1520(%rbp)
    callq read_int
    movq -1480(%rbp), %r10
    movq -1488(%rbp), %r8
    movq -1496(%rbp), %rsi
    movq -1504(%rbp), %rcx
    movq -1512(%rbp), %r9
    movq -1520(%rbp), %rdx
    movq %rax, %r9
    movq %rcx, -1464(%rbp)
    movq -1304(%rbp), %rax
    addq %rax, -1464(%rbp)
    movq -1464(%rbp), %rax
    movq %rax, -1472(%rbp)
    movq -1312(%rbp), %rax
    addq %rax, -1472(%rbp)
    movq -1472(%rbp), %rdi
    movq %r10, -1480(%rbp)
    movq %r8, -1488(%rbp)
    movq %rsi, -1496(%rbp)
    movq %rcx, -1504(%rbp)
    movq %r9, -1512(%rbp)
    movq %rdx, -1520(%rbp)
    callq print_int
    movq -1480(%rbp), %r10
    movq -1488(%rbp), %r8
    movq -1496(%rbp), %rsi
    movq -1504(%rbp), %rcx
    movq -1512(%rbp), %r9
    movq -1520(%rbp), %rdx
    addq -1304(%rbp), %rcx
    addq -1312(%rbp), %rcx
    addq -1320(%rbp), %rcx
    addq -1328(%rbp), %rcx
    addq -1336(%rbp), %rcx
    addq -1344(%rbp), %rcx
    addq -1352(%rbp), %rcx
    addq -1360(%rbp), %rcx
    addq -1368(%rbp), %rcx
    addq -1376(%rbp), %rcx
    addq -1384(%rbp), %rcx
    addq -1392(%rbp), %rcx
    addq -1400(%rbp), %rcx
    addq -1408(%rbp), %rcx
    addq -1416(%rbp), %rcx
    addq -1424(%rbp), %rcx
    addq -1432(%rbp), %rcx
    addq -1440(%rbp), %rcx
    addq -1448(%rbp), %rcx
    addq -1456(%rbp), %rcx
    addq %r10, %rcx
    addq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    movq %rcx, %rdi
    movq %r10, -1480(%rbp)
    movq %r8, -1488(%rbp)
    movq %rsi, -1496(%rbp)
    movq %rcx, -1504(%rbp)
    movq %r9, -1512(%rbp)
    movq %rdx, -1520(%rbp)
    callq print_int
    movq -1480(%rbp), %r10
    movq -1488(%rbp), %r8
    movq -1496(%rbp), %rsi
    movq -1504(%rbp), %rcx
    movq -1512(%rbp), %r9
    movq -1520(%rbp), %rdx
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1552, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1552, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


