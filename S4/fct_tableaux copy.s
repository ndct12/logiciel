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
*/
    .text
    .globl tri_min
tri_min:
    enter $0, $0
    // for (i = 0;
    movq $0, i
for1_tri:
    // i < taille - 1;
    movq taille, %rax
    subq $1, %rax
    cmpq %rax, i
    jnb fin_for1_tri
    // for (ix_min = i, j = i + 1;
    movq i, %rax
    movq %rax, ix_min
    addq $1, %rax
    movq %rax, j
for2_tri:
    // j < taille;
    movq taille, %rax
    cmpq %rax, j
    jnb fin_for2_tri
    // if (tab[j] < tab[ix_min])
    leaq tab, %r10
    movq ix_min, %rax
    movl (%r10, %rax, 4), %eax
    movq j, %r11
    cmpl %eax, (%r10, %r11, 4)
    jnl fin_if_tri
    // ix_min = j;
    movq j, %rax
    movq %rax, ix_min
 fin_if_tri:
    // j++)
    addq $1, j
    jmp for2_tri
 fin_for2_tri:
    // tmp = tab[i];
    leaq tab, %r10
    movq i, %rax
    movl (%r10, %rax, 4), %eax
    movl %eax, tmp
    // tab[i] = tab[ix_min];
    leaq tab, %r10
    movq ix_min, %rax
    movl (%r10, %rax, 4), %eax
    movq i, %r11
    movl %eax, (%r10, %r11, 4)
    // tab[ix_min] = tmp;
    movl tmp, %eax
    leaq tab, %r10
    movq ix_min, %r11
    movl %eax, (%r10, %r11, 4)
    // i++)
    addq $1, i
    jmp for1_tri
 fin_for1_tri:
    leave
    ret

    .data
// uint64_t i;
.comm i, 8
// uint64_t ix_min;
.comm ix_min, 8
// uint64_t j;
.comm j, 8
// int32_t tmp;
.comm tmp, 4

// Attention : il faut absolument remettre une directive
//   indiquant a l'assembleur que ce qui suit est du code,
//   sinon il pensera qu'on est encore dans la zone .data !
    .text
    .globl tri_min_opt
    // %rcx : ix_min
    // %edx : tmp
    // %r8 : i
    // %r9 : j
    // %r10 : taille
    // %r11 : tab
tri_min_opt:
    enter $0, $0
    movq taille, %r10
    leaq tab, %r11
    // for (i = 0;
    movq $0, %r8
for1_tri_opt:
    // i < taille - 1;
    movq %r10, %rax
    subq $1, %rax
    cmpq %rax, %r8
    jnb fin_for1_tri_opt
    // for (ix_min = i, j = i + 1;
    movq %r8, %rcx
    movq %r8, %r9
    addq $1, %r9
for2_tri_opt:
    // j < taille;
    cmpq %r10, %r9
    jnb fin_for2_tri_opt
    // if (tab[j] < tab[ix_min])
    movl (%r11, %rcx, 4), %eax
    cmpl %eax, (%r11, %r9, 4)
    jnl fin_if_tri_opt
    // ix_min = j;
    movq %r9, %rcx
 fin_if_tri_opt:
    // j++)
    addq $1, %r9
    jmp for2_tri_opt
 fin_for2_tri_opt:
    // tmp = tab[i];
    movl (%r11, %r8, 4), %edx
    // tab[i] = tab[ix_min];
    movl (%r11, %rcx, 4), %eax
    movl %eax, (%r11, %r8, 4)
    // tab[ix_min] = tmp;
    movl %edx, (%r11, %rcx, 4)
    // i++)
    addq $1, %r8
    jmp for1_tri_opt
 fin_for1_tri_opt:
    leave
    ret