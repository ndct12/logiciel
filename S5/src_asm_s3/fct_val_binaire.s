/*
uint8_t val_binaire(uint8_t b7, uint8_t b6, uint8_t b5, uint8_t b4,
  uint8_t b3, uint8_t b2, uint8_t b1, uint8_t b0)
{
    return (b7 << 7) | (b6 << 6) | (b5 << 5) | (b4 << 4) |
      (b3 << 3) | (b2 << 2) | (b1 << 1) | b0;
}
*/

    .text
    .globl val_binaire
// uint8_t val_binaire(uint8_t b7, uint8_t b6, uint8_t b5, uint8_t b4,
//     uint8_t b3, uint8_t b2, uint8_t b1, uint8_t b0);
// uint8_t b7 : %dil
// uint8_t b6 : %sil
// uint8_t b5 : %dl
// uint8_t b4 : %cl
// uint8_t b3 : %r8b
// uint8_t b2 : %r9b
// uint8_t b1 : %rbp + 16
// uint8_t b0 : %rbp + 24
val_binaire:
    enter $0, $0
    movb $0, %al
    shlb $7, %dil
    orb %dil, %al
    shlb $6, %sil
    orb %sil, %al
    shlb $5, %dl
    orb %dl, %al
    shlb $4, %cl
    orb %cl, %al
    shlb $3, %r8b
    orb %r8b, %al
    shlb $2, %r9b
    orb %r9b, %al
    shlb $1, 16(%rbp)
    orb 16(%rbp), %al
    orb 24(%rbp), %al
    leave
    ret
