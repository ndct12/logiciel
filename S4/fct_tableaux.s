/*
uint64_t i, j, ix_min;
int32_t tmp;
void tri_min(void)
{
for (i = 0; i < taille - 1; i++) {
for (ix_min = i, j = i + 1; j < taille; j++) {
if (tab[j] < tab[ix_min]) {
ix_min = j;
}
}
tmp = tab[i];
tab[i] = tab[ix_min];
tab[ix_min] = tmp;
}
}
tab et taille variable global 
*/ 

.texte
.globl tri_min
tri_min:
enter $0, $0
// for (i = 0; i < taille - 1; i++) 
movq $0, i
for_tri_i:
movq i, %rax
cmpq taille, %rax
jae fin_for_tri_i
// for (ix_min = i, j = i + 1; j < taille; j++) 
movq i, %rax
movq %rax, ix_min
addq $1, rax
movq %rax, j 
for_tri_j:
movq j, %rax
cmpq taille, %rax 
movq j, %rax 
addq $1, %rax
movq %rax, j
jae fin_for_tri_j
// if (tab[j] < tab[ix_min])
if_tri: 
movq tab, %al
movq j, %bl
movq (%al, %bl), %r10
movq tab, %al
movq ix_min, % bl
movq (%al, %bl), %r11
cmp %r11, %r10
jae fin_if_tri
// ix_min = j;
movq j, %rax 
movq %rax, ix_min
fin_if_tri:
jmp for_tri_j
fin_for_tri_j:
movq i, %rax 
addq $1, %rax
movq %rax, i
jmp for_tri_i
fin_for_tri_i:
// tmp = tab[i];
movq i, %r10
movq tab, %r11
movq (%r11, %r10), %al 
// tab[i] = tab[ix_min];
movq ix_min, %bl 
movq (%r11, %bl), (%r11, %r10)
// tab[ix_min] = tmp;
movq %al, (%r11, %bl)
leave 
ret 


.data
.comm i, 8
.comm j, 8
.comm ix_min, 8 
.comm tmp, 4