/*
uint64_t fact(uint64_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        return n * fact(n - 1);
    }
}
*/
    .text
    .globl fact
    // uint64_t fact(uint64_t n)
    // n : %rdi
fact:
    // on doit sauvegarder le parametre %rdi = n
    enter $16, $0
    movq %rdi, -8(%rbp)
    // if (n <= 1)
    cmpq $1, %rdi
    jnbe else
    // return 1
    movq $1, %rax
    jmp fin
else:
    // return n * fact(n - 1)
    subq $1, %rdi
    call fact
    // on restaure le parametre qu'on avait modifie
    movq -8(%rbp), %rdi
    mulq %rdi
    jno fin
    call erreur_fact
    // la fonction erreur_fact tue le programme
    // inutile ici de restaurer a nouveau %rdi
fin:
    leave
    ret
