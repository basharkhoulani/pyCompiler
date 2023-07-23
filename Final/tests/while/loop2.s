	.align 16
block_191:
    movq $1, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_193:
    movq $0, %rdi
    callq print_int
    jmp loop_192

	.align 16
loop_192:
    movq $1, %rax
    cmpq $2, %rax
    je block_193
    jmp block_191

	.align 16
loop_194:
    jmp loop_192

	.align 16
start:
    jmp loop_194

	.align 16
conclusion:
    addq $352, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $352, %rsp
    jmp start


