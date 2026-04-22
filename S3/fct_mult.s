/* uint64_t mult_simple(void)
{
res = 0;
while (y != 0) {
res = res + x;
y--;
}
return res;
}


*/


.text 
.globl mult_simple

mult_simple:
// res = 0;
movq $0, %rax
//while (y != 0) {
while: 
cmpq $0, y 
je fin_while
// res = res + x;
// y--;
addq x, %rax
subq $1, y 
jmp while
fin_while:
leave 
ret 

/* 
uint64_t mult_egypt(void)
{
res = 0;
while (y != 0) {
if (y % 2 == 1) {
res = res + x;
}
x = x * 2;
y = y / 2;
}
return res;
}
Pour implanter les opérations modulo, multiplier et diviser par 2, vous aurez sûrement besoin des ins-
tructions suivantes :
— test A, B compare A et B en effectuant l’opération A and B ;
— shl $n, A décale A de n bits vers la gauche ;
— shr $n, A décale A de n bits vers la droite (c’est un décalage logique, pas arithmétique).
Indication pour le test de la parité de y : l’instruction test effectue une conjonction logique (and) entre
la constante 1 (qui s’écrit en binaire sur 64 bits "00..(60x 0 au milieu)..01") et y, ce qui peut donner 2
résultats :
— soit 1 ssi le bit 0 de y vaut 1, c’est-à-dire ssi y est impair ;
— soit 0 ssi le bit 0 de y vaut 0, c’est-à-dire ssi y est pair.
Si le résultat du test est 0, alors le flag Z passe à 1, et on peut utiliser l’instruction jz qui effectue le
branchement ssi Z vaut 1 pour sauter le code dans le if ci-dessus.
*/ 

.globl mult_egypt

mult_egypt:
    enter $0, $0
    // res = 0
    movq $0, res
while_e:
    // while (y != 0)
    cmpq $0, y
    je fin_while_e
    // if (y % 2 == 1)
    testq $1, y
    // jmp ssi le nombre est pair
    jz else
    // res = res + x
    movq x, %rax
    addq %rax, res
else:
    // x = x * 2
    shlq $1, x
    // y = y / 2
    shrq $1, y
    jmp while_e
fin_while_e:
    // return res
    movq res, %rax
    leave
    ret


/*
uint64_t mult_native(void)
{
res = x * y;
return res;
}
*/ 

    .globl mult_native
mult_native:
    enter $0, $0
    // return x * y
    movq x, %rax
    mulq y
    leave
    ret

    .data
// uint64_t res;
.comm res, 8

