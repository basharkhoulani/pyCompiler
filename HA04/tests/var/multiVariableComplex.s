	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $592, %rsp
    callq read_int
    movq %rax, -416(%rbp)
    movq -416(%rbp), %rax
    movq %rax, -424(%rbp)
    addq $2, -424(%rbp)
    movq -424(%rbp), %rax
    movq %rax, -432(%rbp)
    callq read_int
    movq %rax, -440(%rbp)
    movq -440(%rbp), %rax
    movq %rax, -448(%rbp)
    addq $4, -448(%rbp)
    movq -448(%rbp), %rax
    movq %rax, -456(%rbp)
    callq read_int
    movq %rax, -464(%rbp)
    movq -464(%rbp), %rax
    movq %rax, -472(%rbp)
    addq $8, -472(%rbp)
    movq -472(%rbp), %rax
    movq %rax, -480(%rbp)
    callq read_int
    movq %rax, -488(%rbp)
    movq -488(%rbp), %rax
    movq %rax, -496(%rbp)
    addq $16, -496(%rbp)
    movq -496(%rbp), %rax
    movq %rax, -504(%rbp)
    callq read_int
    movq %rax, -512(%rbp)
    movq -512(%rbp), %rax
    movq %rax, -520(%rbp)
    addq $32, -520(%rbp)
    movq -520(%rbp), %rax
    movq %rax, -528(%rbp)
    movq -432(%rbp), %rax
    movq %rax, -536(%rbp)
    movq -456(%rbp), %rax
    addq %rax, -536(%rbp)
    movq -536(%rbp), %rax
    movq %rax, -544(%rbp)
    movq -544(%rbp), %rax
    movq %rax, -552(%rbp)
    movq -480(%rbp), %rax
    addq %rax, -552(%rbp)
    movq -552(%rbp), %rax
    movq %rax, -560(%rbp)
    movq -560(%rbp), %rax
    movq %rax, -568(%rbp)
    movq -504(%rbp), %rax
    addq %rax, -568(%rbp)
    movq -568(%rbp), %rax
    movq %rax, -576(%rbp)
    movq -576(%rbp), %rax
    movq %rax, -584(%rbp)
    movq -528(%rbp), %rax
    addq %rax, -584(%rbp)
    movq -584(%rbp), %rax
    movq %rax, -592(%rbp)
    movq -592(%rbp), %rdi
    callq print_int
    addq $592, %rsp
    popq %rbp
    retq 

