.text 

.globl taille_chaine 
inverse_chaine: 
enter $0, $0
movq $0, taille
// adressage global 
for_taille:
// on met juste des registres entre parenthèse pour deréférencer, pas taille !!!!
leaq chaine, %r10
movq taille, %r11
cmpb $0, (%r10, %r11)
// b car on ets sur 8 bits, plus 64 
je fin_for_taille
addq $1, taille
jmp for_taille
fin_for_taille
movq taille, %rax
leave
ret


.globl inverse_chaines
inverse_chaine: 
enter $0, $0

.data 
.comm taille, 8
