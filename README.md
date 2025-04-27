# Orchestre---Base-de-Donn-es-du-Trianon

# PROJET BASE DE DONNÉES

## Contexte

La base de données concerne un petit centre de théâtre, appelé **“Le Trianon”**.  
Le théâtre organise régulièrement des spectacles de tout genre (concerts, stand-up, magie, hypnose, comédie musicale, etc.).

**Le Trianon** possède deux salles :
- **Molière** : une grande salle de 1500 places
- **Victor Hugo** : une plus petite salle de 1000 places.

## Présentation du projet

### Les objectifs

Cette base de données relationnelle a pour objectif principal d'optimiser la gestion des événements et des artistes au sein de la structure événementielle.  
Elle répond aux besoins spécifiques de gestion, d’organisation et de suivi, et vise à garantir une centralisation efficace des informations.

### Les usagers

La base de données sera utilisée par :
- **Les responsables des salles** : pour déterminer la disponibilité des salles à une date précise.
- **Les organisateurs d'événements** : pour planifier les événements et organiser la venue des artistes.
- **Les équipes marketing** : pour promouvoir les différents événements.

### Les besoins informationnels

La base de données répond aux besoins suivants :
- Gestion des salles (capacité, identifiant, disponibilité)
- Gestion des événements (détails de chaque événement)
- Gestion des artistes (informations sur chaque artiste)
- Suivi des participations et des ventes

## Présentation du modèle relationnel

![image](https://github.com/user-attachments/assets/c815ac81-60f7-42f7-8380-de1e1b363e74)


## L’utilité des requêtes

Les requêtes SQL (notamment `SELECT`) seront essentielles pour :
- Organiser les événements
- Suivre l’occupation des salles
- Vérifier le remplissage des spectacles
- Faciliter le travail quotidien des équipes

Quelques exemples de requêtes possibles :
- Afficher le nombre de billets vendus pour le spectacle "**...**"
- Afficher les dates où la salle "**Molière**" est disponible
- Afficher le nombre de places / billets restants pour le spectacle "**...**"
- Afficher la date où sera présent l’artiste "**...**"

---

> Ce projet a été réalisé en binôme dans le cadre du Master 1 DEFI et vise à offrir une gestion centralisée, efficace et évolutive des opérations du théâtre **Le Trianon**.
