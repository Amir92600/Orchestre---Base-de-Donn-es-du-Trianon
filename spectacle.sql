--> CRÉATION DE LA BASE DE DONNÉES


CREATE DATABASE théâtre;
USE théâtre;


CREATE TABLE salle (
    id_salle SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR (50) NOT NULL,
    capacite INT NOT NULL
);


CREATE TABLE evenement (
    id_evenement SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR (100) NOT NULL,
    type VARCHAR (50) NOT NULL,
    date DATE,
    id_salle SMALLINT NOT NULL,
    billetsvendus INT NOT NULL,
    FOREIGN KEY (id_salle) REFERENCES salle(id_salle)
);


CREATE TABLE representation (
    id_evenement SMALLINT NOT NULL,
    id_artiste SMALLINT NOT NULL,
    PRIMARY KEY (id_evenement, id_artiste),
    FOREIGN KEY (id_evenement) REFERENCES evenement(id_evenement),
    FOREIGN KEY (id_artiste) REFERENCES artiste(id_artiste)
);


CREATE TABLE artiste(
    id_artiste SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR (50) NOT NULL,
    prenom VARCHAR (50),
    datenaissance DATE,
    metier VARCHAR (50)
);


INSERT INTO salle
    VALUES (1, "Molière", 1500),
    (2, "Victor Hugo", 1000);


INSERT INTO artiste
    VALUES (1, 'Angelvy', 'Thomas', NULL, 'humoriste'),
    (2, 'Messmer', NULL,'1971-7-2', 'hypnotiseur'),
    (3, 'Garnier', 'Pierre', '2002-3-6', 'chanteur'),
    (4, 'Gardin', 'Blanche', '1977-4-3', 'humoriste, comédienne'),
    (5, 'de Tonquédec', 'Guillaume', '1966-10-18', 'acteur'),
    (6, 'Legendre', 'Loïc', '1978-3-1', 'acteur'),
    (7, 'Meis', 'Lysiane', NULL, 'actrice'),
    (8, 'O Reilly', 'Michael', NULL, 'danseur'),
    (9, 'Marec', 'Justine', NULL, 'comédienne, dançeuse'),
    (10, 'Poux', 'Élodie', '1982-9-3','humsoriste, comédienne');


INSERT INTO evenement
    VALUES (1, 'Thomas Angelvy', 'Stand up', '2025-11-28', 2, 989),
    (2, 'Messmer 13Hz', 'Hypnose', '2025-11-28', 1, 1102),
    (3, 'Messmer 13Hz', 'Hypnose', '2025-11-29', 2, 405),
    (4, 'Chaque Seconde Tour', 'Concert', '2025-11-20', 1, 1254),
    (5,'Chaque Seconde Tour', 'Concert', '2025-11-21', 1, 1500),
    (6,'Chaque Seconde Tour', 'Concert', '2025-11-22', 1, 1488),
    (7, 'Bonne nuit blanche', 'Stand up','2025-11-24', 2, 889),
    (8,'Mon jour de chance', 'Pièce de théâtre','2025-11-22', 1, 1455),  
    (9,'Mon jour de chance', 'Pièce de théâtre','2025-11-23', 1, 1256),
    (10, 'Dirty Dancing', 'Comédie musicale','2025-11-26', 1, 1285),
    (11, 'Élodie Poux', 'Stand up','2025-11-27', 2, 1000);


INSERT INTO representation
    VALUES (1,1),
    (2,2),
    (3,2),
    (4,3),
    (5,3),
    (6,3),
    (7,4),
    (8,5),
    (9,5),
    (8,6),
    (9,6),
    (8,7),
    (9,7),
    (10,8),
    (10,9),
    (11, 10);




--> REQUÊTE SQL




--> Requêtes simple


--> 1. Afficher les événements rangés par dates en ordre croissant

SELECT *
FROM evenement
ORDER BY date


--> 2. Afficher les événements de type stand-up

SELECT * 
FROM evenement 
WHERE LOWER(type)LIKE '%stand up%';




--> 3. Afficher la capacité d'occupation de la salle "Molière"

SELECT capacite 
FROM salle 
WHERE nom = 'Molière';






--> Requêtes avec jointures


--> 1. Afficher la/les date(s) où sera présent l'artiste "Messmer"

SELECT evenement.date
FROM evenement
JOIN representation ON evenement.id_evenement = representation.id_evenement
JOIN artiste ON representation.id_artiste = artiste.id_artiste
WHERE LOWER(artiste.nom) = 'messmer';




--> 2. Afficher les dates où la salle "Victor Hugo" sera occupée

SELECT evenement.date
FROM evenement
JOIN salle ON evenement.id_salle = salle.id_salle
WHERE salle.nom = 'Victor Hugo';




--> 3. Afficher les artistes jouant dans la "Mon jour de chance"

SELECT DISTINCT artiste.*
FROM artiste
JOIN representation ON artiste.id_artiste = representation.id_artiste
JOIN evenement ON representation.id_evenement = evenement.id_evenement
WHERE LOWER(evenement.nom) = 'mon jour de chance'
LIMIT 0, 25;




--> Requêtes d'agrégation


--> 1. Afficher le nombre total de billets vendus pour le "Chaque Seconde Tour"

SELECT SUM(billetsvendus) 
FROM evenement 
WHERE nom = 'Chaque Seconde Tour';


--> 2. Afficher l'événement qui a connu le moins de succès dans les ventes

SELECT * 
FROM evenement 
WHERE billetsvendus = (SELECT MIN(billetsvendus) FROM evenement);








--> Requêtes imbriqués


--> 1. Afficher les dates où les deux salles seront occupées simultanément

SELECT DISTINCT date AS deuxtheatreoccupes
FROM evenement
JOIN salle ON evenement.id_salle = salle.id_salle
WHERE salle.nom LIKE "Victor Hugo"
AND evenement.date IN (SELECT date
FROM evenement
JOIN salle ON evenement.id_salle = salle.id_salle
WHERE salle.nom LIKE "Molière")




--> Requêtes jointure externe


--> 1. Lister tous les artistes et leurs événements associés

SELECT DISTINCT artiste.*, evenement.nom AS evenementassocie
FROM artiste  
JOIN representation ON artiste.id_artiste = representation.id_artiste
LEFT JOIN evenement ON representation.id_evenement = evenement.id_evenement






--> 2. Afficher tous les artistes et les événements auxquels ils sont associés, y compris les artistes qui n'ont encore participé à aucun événement


SELECT artiste.id_artiste, artiste.nom AS artiste, evenement.nom AS evenement, evenement.date
FROM artiste
RIGHT JOIN representation ON artiste.id_artiste = representation.id_artiste
RIGHT JOIN evenement ON representation.id_evenement = evenement.id_evenement
ORDER BY artiste.nom;


--> 3. Afficher toutes les salles et les événements qui y sont programmés, même les salles sans événements prévus


SELECT salle.nom AS salle, evenement.nom AS evenement, evenement.date
FROM salle
LEFT JOIN evenement ON salle.id_salle = evenement.id_salle
ORDER BY salle.nom;
