	.align 16
block_124:
    movq $0, %rax
    jmp conclusion

	.align 16
block_125:
    movq %rcx, %rdi
    callq print_int
    jmp block_124

	.align 16
block_126:
    movq $1, %rcx
    jmp block_125

	.align 16
block_127:
    movq $42, %rcx
    jmp block_125

	.align 16
block_128:
    callq read_int
    movq %rax, %rcx
    movq $42, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    jmp block_124

	.align 16
block_129:
    callq read_int
    movq %rax, %rcx
    cmpq $0, %rcx
    je block_126
    jmp block_127

	.align 16
block_130:
    callq read_int
    movq %rax, %rcx
    callq read_int
    movq %rax, %rdx
    cmpq %rdx, %rcx
    jge block_128
    jmp block_129

	.align 16
start:
    callq read_int
    movq %rax, %rdx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rdx
    je block_130
    jmp block_129

	.align 16
conclusion:
    addq $32, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    jmp start


