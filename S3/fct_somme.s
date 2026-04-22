/* uint8_t i, res;
uint8_t somme(void)
{
res = 0;
for (i = 1; i <= 10; i++) {
res = res + i;
}
return res;
}

Notez bien que dans cet exercice, les variables globales i et res ne sont pas définies dans le programme
principal : vous devez donc compléter la zone .data du programme assembleur pour les définir, en utilisant
la directive .comm comme vu précédemment.
Quand on traduit un programme du C vers l’assembleur, on indiquera toujours la ligne de C en commen-
taire avant la séquence d’instructions assembleur correspondante
*/

.data 


// uint8_t i, res;
.comm i, 1
.comm res, 1

.text
.globl somme 
somme:
    enter $0, $0
    // res = 0;
    movb $0, res
    movb $0, i 
    // for (i = 1; i <= 10; i++) {
        for:
            cmpb $10, i 
            // droite moins gauche, i-10
            ja fin_for 
            // res = res + i;
            movb i, %al
            addb %al, res  
            // origine, dest 
            addb $1, i 
            jmp for
        fin_for:
    movb res, %al
    ret 
    leave 