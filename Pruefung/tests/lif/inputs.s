	.align 16
block_146:
    movq $0, %rax
    jmp conclusion

	.align 16
block_147:
    movq -1752(%rbp), %rdi
    callq print_int
    jmp block_146

	.align 16
block_148:
    movq $1, -1752(%rbp)
    jmp block_147

	.align 16
block_149:
    movq $42, -1752(%rbp)
    jmp block_147

	.align 16
block_150:
    callq read_int
    movq %rax, -1760(%rbp)
    movq $42, -1768(%rbp)
    movq -1760(%rbp), %rax
    addq %rax, -1768(%rbp)
    movq -1768(%rbp), %rdi
    callq print_int
    jmp block_146

	.align 16
block_151:
    callq read_int
    movq %rax, -1776(%rbp)
    cmpq $0, -1776(%rbp)
    je block_148
    jmp block_149

	.align 16
block_152:
    callq read_int
    movq %rax, -1784(%rbp)
    callq read_int
    movq %rax, -1792(%rbp)
    movq -1792(%rbp), %rax
    cmpq %rax, -1784(%rbp)
    jge block_150
    jmp block_151

	.align 16
start:
    callq read_int
    movq %rax, -1800(%rbp)
    callq read_int
    movq %rax, -1808(%rbp)
    movq -1808(%rbp), %rax
    cmpq %rax, -1800(%rbp)
    je block_152
    jmp block_151

	.align 16
conclusion:
    addq $1808, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1808, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


