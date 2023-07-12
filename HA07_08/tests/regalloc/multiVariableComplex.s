	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $560, %rsp
    movq %rdx, -488(%rbp)
    movq %rsi, -496(%rbp)
    movq %r11, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r10, -520(%rbp)
    movq %r8, -528(%rbp)
    movq %r9, -536(%rbp)
    callq read_int
    movq -488(%rbp), %rdx
    movq -496(%rbp), %rsi
    movq -504(%rbp), %r11
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r10
    movq -528(%rbp), %r8
    movq -536(%rbp), %r9
    movq %rax, %rcx
    addq $2, %rcx
    movq %rcx, %rdx
    movq %rdx, -488(%rbp)
    movq %rsi, -496(%rbp)
    movq %r11, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r10, -520(%rbp)
    movq %r8, -528(%rbp)
    movq %r9, -536(%rbp)
    callq read_int
    movq -488(%rbp), %rdx
    movq -496(%rbp), %rsi
    movq -504(%rbp), %r11
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r10
    movq -528(%rbp), %r8
    movq -536(%rbp), %r9
    movq %rax, %rcx
    addq $4, %rcx
    movq %rcx, %rsi
    movq %rdx, -488(%rbp)
    movq %rsi, -496(%rbp)
    movq %r11, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r10, -520(%rbp)
    movq %r8, -528(%rbp)
    movq %r9, -536(%rbp)
    callq read_int
    movq -488(%rbp), %rdx
    movq -496(%rbp), %rsi
    movq -504(%rbp), %r11
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r10
    movq -528(%rbp), %r8
    movq -536(%rbp), %r9
    movq %rax, %rcx
    addq $8, %rcx
    movq %rcx, %r8
    movq %rdx, -488(%rbp)
    movq %rsi, -496(%rbp)
    movq %r11, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r10, -520(%rbp)
    movq %r8, -528(%rbp)
    movq %r9, -536(%rbp)
    callq read_int
    movq -488(%rbp), %rdx
    movq -496(%rbp), %rsi
    movq -504(%rbp), %r11
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r10
    movq -528(%rbp), %r8
    movq -536(%rbp), %r9
    movq %rax, %rcx
    addq $16, %rcx
    movq %rcx, %r9
    movq %rdx, -488(%rbp)
    movq %rsi, -496(%rbp)
    movq %r11, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r10, -520(%rbp)
    movq %r8, -528(%rbp)
    movq %r9, -536(%rbp)
    callq read_int
    movq -488(%rbp), %rdx
    movq -496(%rbp), %rsi
    movq -504(%rbp), %r11
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r10
    movq -528(%rbp), %r8
    movq -536(%rbp), %r9
    movq %rax, %rcx
    addq $32, %rcx
    movq %rcx, %r10
    movq %rdx, %rcx
    addq %rsi, %rcx
    addq %r8, %rcx
    addq %r9, %rcx
    addq %r10, %rcx
    movq %rcx, %rdi
    movq %rdx, -488(%rbp)
    movq %rsi, -496(%rbp)
    movq %r11, -504(%rbp)
    movq %rcx, -512(%rbp)
    movq %r10, -520(%rbp)
    movq %r8, -528(%rbp)
    movq %r9, -536(%rbp)
    callq print_int
    movq -488(%rbp), %rdx
    movq -496(%rbp), %rsi
    movq -504(%rbp), %r11
    movq -512(%rbp), %rcx
    movq -520(%rbp), %r10
    movq -528(%rbp), %r8
    movq -536(%rbp), %r9
    addq $560, %rsp
    popq %rbp
    retq 

