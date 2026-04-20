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
jne fin_while
// res = res + x;
// y--;
addq x, %rax
subq $1, y 
fin_while: 
ret 
leave
