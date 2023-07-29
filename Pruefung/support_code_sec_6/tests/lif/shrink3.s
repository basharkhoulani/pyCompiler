	.align 16
block_134:
    movq $0, %rax
    jmp conclusion

	.align 16
block_135:
    movq $0, %rdi
    callq print_int
    jmp block_134

	.align 16
block_136:
    movq $1, %rdi
    callq print_int
    jmp block_134

	.align 16
start:
    jmp block_136

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


