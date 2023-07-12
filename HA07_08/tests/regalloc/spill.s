	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $720, %rsp
    movq $1, %rcx
    movq $1, -488(%rbp)
    movq $1, -496(%rbp)
    movq $1, -504(%rbp)
    movq $1, -512(%rbp)
    movq $1, -520(%rbp)
    movq $1, -528(%rbp)
    movq $1, -536(%rbp)
    movq $1, -544(%rbp)
    movq $1, -552(%rbp)
    movq $1, -560(%rbp)
    movq $1, -568(%rbp)
    movq $1, -576(%rbp)
    movq $1, -584(%rbp)
    movq $1, -592(%rbp)
    movq $1, -600(%rbp)
    movq $1, -608(%rbp)
    movq $1, -616(%rbp)
    movq $1, -624(%rbp)
    movq $1, -632(%rbp)
    movq $1, %rdx
    movq $1, %rsi
    movq $1, %r8
    movq $1, %r9
    movq $1, %r10
    movq $1, %r11
    addq -488(%rbp), %rcx
    addq -496(%rbp), %rcx
    addq -504(%rbp), %rcx
    addq -512(%rbp), %rcx
    addq -520(%rbp), %rcx
    addq -528(%rbp), %rcx
    addq -536(%rbp), %rcx
    addq -544(%rbp), %rcx
    addq -552(%rbp), %rcx
    addq -560(%rbp), %rcx
    addq -568(%rbp), %rcx
    addq -576(%rbp), %rcx
    addq -584(%rbp), %rcx
    addq -592(%rbp), %rcx
    addq -600(%rbp), %rcx
    addq -608(%rbp), %rcx
    addq -616(%rbp), %rcx
    addq -624(%rbp), %rcx
    addq -632(%rbp), %rcx
    addq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    addq %r10, %rcx
    addq %r11, %rcx
    movq %rcx, %rdi
    movq %rcx, -640(%rbp)
    movq %rdx, -648(%rbp)
    movq %r11, -656(%rbp)
    movq %r9, -664(%rbp)
    movq %r10, -672(%rbp)
    movq %rsi, -680(%rbp)
    movq %r8, -688(%rbp)
    callq print_int
    movq -640(%rbp), %rcx
    movq -648(%rbp), %rdx
    movq -656(%rbp), %r11
    movq -664(%rbp), %r9
    movq -672(%rbp), %r10
    movq -680(%rbp), %rsi
    movq -688(%rbp), %r8
    addq $720, %rsp
    popq %rbp
    retq 

