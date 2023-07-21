	.align 16
start:
    callq read_int
    movq %rax, -816(%rbp)
    movq $1, -824(%rbp)
    movq $1, -832(%rbp)
    movq $1, -840(%rbp)
    movq $1, -848(%rbp)
    movq $1, -856(%rbp)
    movq $1, -864(%rbp)
    movq $1, -872(%rbp)
    movq $1, -880(%rbp)
    callq read_int
    movq %rax, -888(%rbp)
    movq $1, -896(%rbp)
    movq $1, -904(%rbp)
    movq $1, -912(%rbp)
    movq $1, -920(%rbp)
    movq $1, -928(%rbp)
    movq $1, -936(%rbp)
    movq $1, -944(%rbp)
    movq $1, -952(%rbp)
    movq $1, -960(%rbp)
    movq $1, -968(%rbp)
    movq $1, -976(%rbp)
    movq $1, -984(%rbp)
    movq $1, -992(%rbp)
    movq $1, -1000(%rbp)
    movq $1, -1008(%rbp)
    callq read_int
    movq %rax, -1016(%rbp)
    movq -816(%rbp), %rax
    movq %rax, -1024(%rbp)
    movq -824(%rbp), %rax
    addq %rax, -1024(%rbp)
    movq -1024(%rbp), %rax
    movq %rax, -1032(%rbp)
    movq -832(%rbp), %rax
    addq %rax, -1032(%rbp)
    movq -1032(%rbp), %rdi
    callq print_int
    movq -816(%rbp), %rax
    movq %rax, -1040(%rbp)
    movq -824(%rbp), %rax
    addq %rax, -1040(%rbp)
    movq -1040(%rbp), %rax
    movq %rax, -1048(%rbp)
    movq -832(%rbp), %rax
    addq %rax, -1048(%rbp)
    movq -1048(%rbp), %rax
    movq %rax, -1056(%rbp)
    movq -840(%rbp), %rax
    addq %rax, -1056(%rbp)
    movq -1056(%rbp), %rax
    movq %rax, -1064(%rbp)
    movq -848(%rbp), %rax
    addq %rax, -1064(%rbp)
    movq -1064(%rbp), %rax
    movq %rax, -1072(%rbp)
    movq -856(%rbp), %rax
    addq %rax, -1072(%rbp)
    movq -1072(%rbp), %rax
    movq %rax, -1080(%rbp)
    movq -864(%rbp), %rax
    addq %rax, -1080(%rbp)
    movq -1080(%rbp), %rax
    movq %rax, -1088(%rbp)
    movq -872(%rbp), %rax
    addq %rax, -1088(%rbp)
    movq -1088(%rbp), %rax
    movq %rax, -1096(%rbp)
    movq -880(%rbp), %rax
    addq %rax, -1096(%rbp)
    movq -1096(%rbp), %rax
    movq %rax, -1104(%rbp)
    movq -888(%rbp), %rax
    addq %rax, -1104(%rbp)
    movq -1104(%rbp), %rax
    movq %rax, -1112(%rbp)
    movq -896(%rbp), %rax
    addq %rax, -1112(%rbp)
    movq -1112(%rbp), %rax
    movq %rax, -1120(%rbp)
    movq -904(%rbp), %rax
    addq %rax, -1120(%rbp)
    movq -1120(%rbp), %rax
    movq %rax, -1128(%rbp)
    movq -912(%rbp), %rax
    addq %rax, -1128(%rbp)
    movq -1128(%rbp), %rax
    movq %rax, -1136(%rbp)
    movq -920(%rbp), %rax
    addq %rax, -1136(%rbp)
    movq -1136(%rbp), %rax
    movq %rax, -1144(%rbp)
    movq -928(%rbp), %rax
    addq %rax, -1144(%rbp)
    movq -1144(%rbp), %rax
    movq %rax, -1152(%rbp)
    movq -936(%rbp), %rax
    addq %rax, -1152(%rbp)
    movq -1152(%rbp), %rax
    movq %rax, -1160(%rbp)
    movq -944(%rbp), %rax
    addq %rax, -1160(%rbp)
    movq -1160(%rbp), %rax
    movq %rax, -1168(%rbp)
    movq -952(%rbp), %rax
    addq %rax, -1168(%rbp)
    movq -1168(%rbp), %rax
    movq %rax, -1176(%rbp)
    movq -960(%rbp), %rax
    addq %rax, -1176(%rbp)
    movq -1176(%rbp), %rax
    movq %rax, -1184(%rbp)
    movq -968(%rbp), %rax
    addq %rax, -1184(%rbp)
    movq -1184(%rbp), %rax
    movq %rax, -1192(%rbp)
    movq -976(%rbp), %rax
    addq %rax, -1192(%rbp)
    movq -1192(%rbp), %rax
    movq %rax, -1200(%rbp)
    movq -984(%rbp), %rax
    addq %rax, -1200(%rbp)
    movq -1200(%rbp), %rax
    movq %rax, -1208(%rbp)
    movq -992(%rbp), %rax
    addq %rax, -1208(%rbp)
    movq -1208(%rbp), %rax
    movq %rax, -1216(%rbp)
    movq -1000(%rbp), %rax
    addq %rax, -1216(%rbp)
    movq -1216(%rbp), %rax
    movq %rax, -1224(%rbp)
    movq -1008(%rbp), %rax
    addq %rax, -1224(%rbp)
    movq -1224(%rbp), %rax
    movq %rax, -1232(%rbp)
    movq -1016(%rbp), %rax
    addq %rax, -1232(%rbp)
    movq -1232(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
conclusion:
    addq $1232, %rsp
    popq %rbp
    retq 

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $1232, %rsp
    movq $16384, %rdi
    movq $16384, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    jmp start


