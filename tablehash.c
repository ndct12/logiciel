#include "liste.h"
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>

#define TAILLE_TABLE 4

struct tablehash_t {
    uint64_t nbr_elem;
    struct liste_t *table[TAILLE_TABLE];
};

static int64_t hash(uint8_t x)
{
    return x % TAILLE_TABLE;
}

struct tablehash_t* nouv_tablehash(void)
{
    struct tablehash_t *th = malloc(sizeof(struct tablehash_t));
    assert(th != NULL);

    th->nbr_elem = 0;

    for (size_t i = 0; i < TAILLE_TABLE; i++)
    {
        th->table[i] = nouv_liste();
        assert(th->table[i] != NULL);
    }

    return th;
}

bool est_vide_tablehash(struct tablehash_t *th)
{
    assert(th != NULL);
    return th->nbr_elem == 0;
}

void inserer_val_tablehash(uint8_t val, struct tablehash_t *th)
{
    assert(th != NULL);

    int64_t idx = hash(val);

    inserer_tete_liste(val, th->table[idx]);

    th->nbr_elem++;
}

void supprimer_val_tablehash(uint8_t val, struct tablehash_t *th)
{
    assert(th != NULL);

    int64_t idx = hash(val);

    if (supprimer_val_liste(val, th->table[idx]))
    {
        th->nbr_elem--;
    }
}

void afficher_tablehash(struct tablehash_t *th)
{
    assert(th != NULL);
    for (size_t i = 0; i < TAILLE_TABLE; i++)
    {
        afficher_liste(th->table[i]);
    }
}


void detruire_tablehash(struct tablehash_t **th)
{
    assert(th != NULL);
     for (size_t i = 0; i < TAILLE_TABLE; i++)
     {
          detruire_liste(&((*th)->table[i]));
     }
     free(*th);
     *th = NULL;
}

