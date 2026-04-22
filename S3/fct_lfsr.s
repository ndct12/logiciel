    .text

    .globl init_aleat
init_aleat:
    enter $0, $0
    rdtsc
    movw %ax, etat
    leave
    ret

/*
    etat = (etat >> 1) ^ (-(etat & 1) & 0xB400)
*/
    .globl aleat
aleat:
    enter $0, $0
    movw etat, %ax
    movw %ax, %r10w
    andw $1, %ax
    negw %ax
    andw $0xB400, %ax
    shrw $1, %r10w
    xorw %r10w, %ax
    movw %ax, etat
    leave
    ret
