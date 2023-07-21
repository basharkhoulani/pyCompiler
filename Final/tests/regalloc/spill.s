	.align 16
start:
    movq $1, -344(%rbp)
    movq $1, -352(%rbp)
    movq $1, -360(%rbp)
    movq $1, -368(%rbp)
    movq $1, -376(%rbp)
    movq $1, -384(%rbp)
    movq $1, -392(%rbp)
    movq $1, -400(%rbp)
    movq $1, -408(%rbp)
    movq $1, -416(%rbp)
    movq $1, -424(%rbp)
    movq $1, -432(%rbp)
    movq $1, -440(%rbp)
    movq $1, -448(%rbp)
    movq $1, -456(%rbp)
    movq $1, -464(%rbp)
    movq $1, -472(%rbp)
    movq $1, -480(%rbp)
    movq $1, -488(%rbp)
    movq $1, -496(%rbp)
    movq $1, -504(%rbp)
    movq $1, -512(%rbp)
    movq $1, -520(%rbp)
    movq $1, -528(%rbp)
    movq $1, -536(%rbp)
    movq $1, -544(%rbp)
    movq -344(%rbp), %rax
    movq %rax, -552(%rbp)
    movq -352(%rbp), %rax
    addq %rax, -552(%rbp)
    movq -552(%rbp), %rax
    movq %rax, -560(%rbp)
    movq -360(%rbp), %rax
    addq %rax, -560(%rbp)
    movq -560(%rbp), %rdi
    callq print_int
    movq -344(%rbp), %rax
    movq %rax, -568(%rbp)
    movq -352(%rbp), %rax
    addq %rax, -568(%rbp)
    movq -568(%rbp), %rax
    movq %rax, -576(%rbp)
    movq -360(%rbp), %rax
    addq %rax, -576(%rbp)
    movq -576(%rbp), %rax
    movq %rax, -584(%rbp)
    movq -368(%rbp), %rax
    addq %rax, -584(%rbp)
    movq -584(%rbp), %rax
    movq %rax, -592(%rbp)
    movq -376(%rbp), %rax
    addq %rax, -592(%rbp)
    movq -592(%rbp), %rax
    movq %rax, -600(%rbp)
    movq -384(%rbp), %rax
    addq %rax, -600(%rbp)
    movq -600(%rbp), %rax
    movq %rax, -608(%rbp)
    movq -392(%rbp), %rax
    addq %rax, -608(%rbp)
    movq -608(%rbp), %rax
    movq %rax, -616(%rbp)
    movq -400(%rbp), %rax
    addq %rax, -616(%rbp)
    movq -616(%rbp), %rax
    movq %rax, -624(%rbp)
    movq -408(%rbp), %rax
    addq %rax, -624(%rbp)
    movq -624(%rbp), %rax
    movq %rax, -632(%rbp)
    movq -416(%rbp), %rax
    addq %rax, -632(%rbp)
    movq -632(%rbp), %rax
    movq %rax, -640(%rbp)
    movq -424(%rbp), %rax
    addq %rax, -640(%rbp)
    movq -640(%rbp), %rax
    movq %rax, -648(%rbp)
    movq -432(%rbp), %rax
    addq %rax, -648(%rbp)
    movq -648(%rbp), %rax
    movq %rax, -656(%rbp)
    movq -440(%rbp), %rax
    addq %rax, -656(%rbp)
    movq -656(%rbp), %rax
    movq %rax, -664(%rbp)
    movq -448(%rbp), %rax
    addq %rax, -664(%rbp)
    movq -664(%rbp), %rax
    movq %rax, -672(%rbp)
    movq -456(%rbp), %rax
    addq %rax, -672(%rbp)
    movq -672(%rbp), %rax
    movq %rax, -680(%rbp)
    movq -464(%rbp), %rax
    addq %rax, -680(%rbp)
    movq -680(%rbp), %rax
    movq %rax, -688(%rbp)
    movq -472(%rbp), %rax
    addq %rax, -688(%rbp)
    movq -688(%rbp), %rax
    movq %rax, -696(%rbp)
    movq -480(%rbp), %rax
    addq %rax, -696(%rbp)
    movq -696(%rbp), %rax
    movq %rax, -704(%rbp)
    movq -488(%rbp), %rax
    addq %rax, -704(%rbp)
    movq -704(%rbp), %rax
    movq %rax, -712(%rbp)
    movq -496(%rbp), %rax
    addq %rax, -712(%rbp)
    movq -712(%rbp), %rax
    movq %rax, -720(%rbp)
    movq -504(%rbp), %rax
    addq %rax, -720(%rbp)
    movq -720(%rbp), %rax
    movq %rax, -728(%rbp)
    movq -512(%rbp), %rax
    addq %rax, -728(%rbp)
    movq -728(%rbp), %rax
    movq %rax, -736(%rbp)
    movq -520(%rbp), %rax
    addq %rax, -736(%rbp)
    movq -736(%rbp), %rax
    movq %rax, -744(%rbp)
    movq -528(%rbp), %rax
    addq %rax, -744(%rbp)
    movq -744(%rbp), %rax
    movq %rax, -752(%rbp)
    movq -536(%rbp), %rax
    addq %rax, -752(%rbp)
    movq -752(%rbp), %rax
    movq %rax, -760(%rbp)
    movq -544(%rbp), %rax
    addq %rax, -760(%rbp)
    movq -760(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $768, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $768, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


