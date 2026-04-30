/*
uint16_t age(uint16_t annee_naissance)
{
uint16_t age;
age = 2026 - annee_naissance;
return age;
}
*/ 

.text
.globl age
age:
    enter $16, $0
    // age = 2026 - annee_naissance;
    movw $2026, -8(%rbp)
    subw %di, -8(%rbp)
    // return age;
    movw -8(%rbp), %ax
    leave
    ret



