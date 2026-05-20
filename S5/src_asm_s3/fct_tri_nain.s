/*
void tri_nain(int32_t tab[], uint64_t taille)
{
    for (uint64_t i = 0; i < taille - 1; ) {
        if (tab[i] > tab[i+1]) {
            int32_t tmp = tab[i];
            tab[i] = tab[i+1];
            tab[i + 1] = tmp;
            if (i > 0) {
                i = i - 1;
            }
        } else {
            i = i + 1;
        }
    }
}
*/
    .text
    .globl tri_nain
    // void tri_nain(int32_t tab[], uint64_t taille)
    // tab : %rdi
    // taille : %rsi
tri_nain:
    // uint64_t i : %rbp - 8
    // int32_t tmp : %rbp - 16
    enter $16, $0
    // i = 0;
    movq $0, -8(%rbp)
for:
    // i < taille - 1
    movq %rsi, %rax
    subq $1, %rax
    cmpq %rax, -8(%rbp)
    jnb fin_for
    // if (tab[i] > tab[i+1])
    movq -8(%rbp), %r11
    movl (%rdi, %r11, 4), %eax
    cmpl %eax, 4(%rdi, %r11, 4)
    jnl else
    // tmp = tab[i];
    movq -8(%rbp), %r11
    movl (%rdi, %r11, 4), %eax
    movl %eax, -16(%rbp)
    // tab[i] = tab[i+1];
    movq -8(%rbp), %r11
    movl 4(%rdi, %r11, 4), %eax
    movl %eax, (%rdi, %r11, 4)
    // tab[i + 1] = tmp;
    movl -16(%rbp), %eax
    movq -8(%rbp), %r11
    movl %eax, 4(%rdi, %r11, 4)
    // if (i > 0)
    cmpq $0, -8(%rbp)
    jna fin_if2
    // i = i - 1;
    subq $1, -8(%rbp)
fin_if2:
    jmp fin_if1
else:
    // i = i + 1;
    addq $1, -8(%rbp)
fin_if1:
    jmp for
fin_for:
    leave
    ret

    .text
    .globl tri_nain_opt
    // void tri_nain_opt(int32_t tab[], uint64_t taille)
    // tab : %rdi
    // taille : %rsi
    // i : %r10
    // tmp : %r11d
tri_nain_opt:
    enter $0, $0
    // i = 0;
    movq $0, %r10
    subq $1, %rsi
for_opt:
    // i < taille - 1
    cmpq %rsi, %r10
    jnb fin_for_opt
    // if (tab[i] > tab[i+1])
    movl (%rdi, %r10, 4), %eax
    cmpl %eax, 4(%rdi, %r10, 4)
    jnl else_opt
    // tmp = tab[i];
    movl (%rdi, %r10, 4), %r11d
    // tab[i] = tab[i+1];
    movl 4(%rdi, %r10, 4), %eax
    movl %eax, (%rdi, %r10, 4)
    // tab[i + 1] = tmp;
    movl %r11d, 4(%rdi, %r10, 4)
    // if (i > 0)
    cmpq $0, %r10
    jna fin_if2_opt
    // i = i - 1;
    subq $1, %r10
fin_if2_opt:
    jmp fin_if1_opt
else_opt:
    // i = i + 1;
    addq $1, %r10
fin_if1_opt:
    jmp for_opt
fin_for_opt:
    leave
    ret
