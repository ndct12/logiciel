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

/* 
int64_t dep;
char *ptr;
char tmp;
void inverse_chaine(void)
{
dep = taille - 1;
ptr = chaine; // attention : ici, on copie dans ptr l’adresse de la chaine

while (dep > 0) {
tmp = *ptr; valeur qui est  a l'adresse ptr 
*ptr = ptr[dep];
ptr[dep] = tmp;
dep = dep - 2;
ptr++;
}
}
On conseille de commencer par compléter la zone .data du module assembleur et de bien faire attention
aux types et aux tailles des données manipulées.
Mettre au point le programme en utilisant GDB et en affichant la chaine résultat à la fin. On rappelle que
si par exemple %al contient un caractère, on peut facilement afficher son contenu grâce à la commande
display /c $rax. Pour afficher la chaine au fur et a mesure de son inversion, le plus simple est d’utiliser
la commande display *chaine@6 (si la chaine contient 6 caractères
*/ 

.globl inverse_chaine
inverse_chaine:
  enter $0, $0
  // dep = taille
  movq taille, %r10
  // dep = taille - 1
  subq $1, %r10
  // ptr = chaine
  leaq chaine, %r11
while:
  // dep > 0 ?
  cmpq $0, %r10
  // Sinon, fin_while
  jle fin_while
  // tmp = *ptr
  movb (%r11), %al
  // *ptr = ptr[dep]
  movb (%r11, %r10, 1), %bl
  movb %bl, (%r11)
  // ptr[dep] = tmp
  movb %al, (%r11, %r10)
  // dep = dep - 2
  subq $2, %r10
  // ptr++
  addq $1, %r11
  jmp while
fin_while:
  leave
  ret

  
.data 
.comm taille, 8
.comm ptr, 1
.comm tmp, 1
.comm dep, 8
