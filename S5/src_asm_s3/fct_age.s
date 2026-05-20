/*
uint16_t age(uint16_t annee_naissance)
{
    uint16_t age;
    age = 2025 - annee_naissance;
    return age;
}
*/
    .text
    .globl age
    // uint16_t age(uint16_t annee_naissance)
    // annee_naissance : %di
age:
    // uint16_t age : %rbp - 2
    enter $16, $0
    // age = 2025 - annee_naissance;
    subw $2025, %di
    negw %di
    movw %di, -2(%rbp)
    // return age
    movw -2(%rbp), %ax
    leave
    ret
