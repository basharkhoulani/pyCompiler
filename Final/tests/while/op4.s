	.align 16
block_210:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block_212:
    subq $1, %rcx
    jmp loop_211

	.align 16
loop_211:
    cmpq $1, %rcx
    jge block_212
    jmp block_210

	.align 16
start:
    movq $10, %rcx
    jmp loop_211

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


