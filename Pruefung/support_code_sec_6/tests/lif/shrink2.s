	.align 16
block_131:
    movq $0, %rax
    jmp conclusion

	.align 16
block_132:
    movq $0, %rdi
    callq print_int
    jmp block_131

	.align 16
block_133:
    movq $1, %rdi
    callq print_int
    jmp block_131

	.align 16
start:
    jmp block_133

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


