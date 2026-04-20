#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>


struct cell_t {
    uint8_t val;
    struct cell_t *suiv;
};

struct liste_t {
    struct cell_t tete;
};

struct liste_t * nouv_liste(void) // * toujours avant le nom de la var, ici c'est commme en java public int nomFonction(), il n'y a pas de nom de var de retour juuste le type 
{
    struct liste_t *liste = malloc(sizeof(struct liste_t));
    assert(liste != NULL); // vérifie que malloc a réussi

    // Initialisation de la sentinelle
    liste->tete.suiv = NULL;

    // (optionnel) initialiser val pour être propre
    liste->tete.val = 0;

    return liste;
}

bool est_vide_liste(struct liste_t *liste)
{
    assert(liste != NULL);
    return liste->tete.suiv == NULL;
}

void inserer_tete_liste(uint8_t val, struct liste_t *liste)
{
    assert(liste != NULL);
    struct cell_t *nouvelle = malloc(sizeof(struct cell_t ));
    assert(nouvelle != NULL);
    nouvelle->val = val; //(*nouvelle).val = val; on déréference pour avoir accès a l'objet 
    nouvelle->suiv = liste->tete.suiv; //(*nouvelle).suiv = (*liste).tete.suiv

    liste->tete.suiv = nouvelle; //(*liste).tete.suiv= nouvelle 
    // liste tete.suiv est dynamique, ne réprésente pas la même chose sur les deux lignes
}

bool supprimer_val_liste(uint8_t val, struct liste_t *liste)
{
    assert(liste != NULL);

    struct cell_t *prec = &((*liste).tete);
    struct cell_t *courant = liste->tete.suiv;

    while (courant != NULL)
    {
        if (courant->val == val)
        {
            prec->suiv = courant->suiv;
            free(courant);
            return true;
        }

        prec = courant;
        courant = courant->suiv;
    }

    return false;
}

void afficher_liste(struct liste_t *liste)
{
    assert(liste != NULL);
    struct cell_t *courant = liste->tete.suiv;

    while (courant != NULL)
    {
        printf("%" PRIu8 " ", courant->val);
        courant = courant->suiv;
    }
    printf("\n");
}

void detruire_liste(struct liste_t **liste) // *liste est la vraie liste car deferencement 
{
    assert(liste != NULL && *liste != NULL);
    struct cell_t *courant = (*liste)->tete.suiv;

    while (courant != NULL)
    {
        struct cell_t *temp = courant;
        courant = courant->suiv;
        free(temp);
    }

    free(*liste);
    *liste = NULL; // éviter les pointeurs pendants
}