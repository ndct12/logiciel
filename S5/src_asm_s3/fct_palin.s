/*
bool palin(char *chaine)
{
    uint64_t inf, sup;
    for (inf = 0, sup = strlen(chaine) - 1; (inf < sup) && (chaine[inf] == chaine[sup]); inf++, sup--);
    return inf >= sup;
}
*/
    .text
    .globl palin
    // bool palin(char *chaine)
    // chaine : %rdi
palin:
    // uint64_t inf : %rbp - 8
    // uint64_t sup : %rbp - 16
    // on reserve de la place pour la sauvegarde de %rdi a %rbp - 24
    enter $32, $0
    movq %rdi, -24(%rbp)
    // for (inf = 0,
    movq $0, -8(%rbp)
    // sup = strlen(chaine) - 1;
    call strlen
    // restauration du %rdi initial, strlen a pu le modifier
    movq -24(%rbp), %rdi
    subq $1, %rax
    movq %rax, -16(%rbp)
for:
    // (inf < sup) && (chaine[inf] == chaine[sup]);
    movq -8(%rbp), %rax
    movq -16(%rbp), %r11
    cmpq %rax, %r11
    jna fin_for
    movb (%rdi, %rax), %al
    cmpb %al, (%rdi, %r11)
    jne fin_for
    // inf++
    addq $1, -8(%rbp)
    // sup--
    subq $1, -16(%rbp)
    jmp for
fin_for:
    // return inf >= sup
    movq -16(%rbp), %rax
    cmpq %rax, -8(%rbp)
    setae %al
    leave
    ret
