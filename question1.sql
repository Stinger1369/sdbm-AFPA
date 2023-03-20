
-- Question 1
-- Quels sont les tickets qui comportent l'article d'ID 500 ? Afficher le numéro de ticket uniquement.

SELECT ANNEE, FORMAT(NUMERO_TICKET, '00000') AS 'N°'
FROM VENDRE
WHERE ID_ARTICLE = 500;

SELECT ANNEE, CONCAT('N°', LPAD(NUMERO_TICKET, 5, '0')) AS 'N°'
FROM VENDRE
WHERE ID_ARTICLE = 500;


-- Question 2
-- Quels sont les les tickets du 15/01/2017 ? Afficher le numéro de ticket et la date.

SELECT ANNEE as DATE, Numero_Ticket as N°Ticket
FROM Ticket
--WHERE Date_vente = '2017-01-15';
WHERE Date_vente in ('2017-01-15');


-- Question 4
-- Éditer la liste des articles (Code et nom uniquement) apparaissant sur un ticket à au moins 95 exemplaires.

SELECT DISTINCT V.ID_ARTICLE AS Code, A.NOM_ARTICLE AS Nom
FROM VENDRE V
INNER JOIN ARTICLE A ON V.ID_ARTICLE = A.ID_ARTICLE
WHERE V.QUANTITE >= 95;


-- Question 5
-- Quels sont les tickets émis au mois de mars 2017 ? Afficher le numéro de ticket et la date.

SELECT ANNEE, Numero_Ticket, Date_vente
FROM Ticket
WHERE Date_vente BETWEEN '2017-03-01' AND '2017-03-31';

SELECT ANNEE, Numero_Ticket, Date_vente
FROM Ticket
WHERE MONTH(Date_vente) = 3 AND YEAR(Date_vente) = 2017;

-- Question 6
--Quels sont les tickets émis au deuxième trimestre 2017 ? Afficher le numéro de ticket et la date.

Select ANNEE, Numero_Ticket, Date_vente
FROM Ticket
WHERE Date_vente BETWEEN '2017-04-01' AND '2017-06-30';

SELECT ANNEE, Numero_Ticket, Date_vente
FROM Ticket
WHERE MONTH(Date_vente) BETWEEN 4 AND 6 AND YEAR(Date_vente) = 2017;

-- Question 7
-- Quels sont les tickets émis au mois de mars et juillet 2017 ? Afficher le numéro de ticket et la date.

SELECT ANNEE, Numero_Ticket, Date_vente
FROM Ticket
WHERE MONTH(Date_vente) IN (3, 7) AND YEAR(Date_vente) = 2017;


-- Question 8
-- Afficher la liste de toutes les bières classée par couleur. (Afficher code et nom de bière, nom de la couleur)

SELECT A.ID_ARTICLE AS Code, A.NOM_ARTICLE AS Nom, C.NOM_COULEUR AS Couleur
FROM ARTICLE A
INNER JOIN COULEUR C ON A.ID_COULEUR = C.ID_COULEUR
WHERE A.ID_TYPE = 1
ORDER BY C.NOM_COULEUR;

-- Question 9
--Donnez la liste des bières de même couleur et de même type que la bière ayant le code 142.

SELECT A.ID_ARTICLE AS Code, A.NOM_ARTICLE AS Nom, C.NOM_COULEUR AS Couleur, T.NOM_TYPE AS Type
FROM ARTICLE A
INNER JOIN COULEUR C ON A.ID_COULEUR = C.ID_COULEUR
INNER JOIN TYPEBIERE T ON A.ID_TYPE = T.ID_TYPE
WHERE A.ID_COULEUR = (SELECT ID_COULEUR FROM ARTICLE WHERE ID_ARTICLE = 142)
AND A.ID_TYPE = (SELECT ID_TYPE FROM ARTICLE WHERE ID_ARTICLE = 142)
AND A.ID_ARTICLE <> 142;

--Question 11
--Lister pour chaque ticket la quantité totale d'articles vendus. (Classer par quantité décroissante)

SELECT ANNEE, Numero_Ticket, SUM(QUANTITE) AS QuantitéTotale
FROM VENDRE
GROUP BY ANNEE, Numero_Ticket
ORDER BY SUM(QUANTITE) DESC;

--Question 12
--Lister chaque ticket pour lequel la quantité totale d'articles vendus est inférieure à 50. (Classer par quantité croissante)

SELECT ANNEE, Numero_Ticket, SUM(QUANTITE) AS QuantitéTotale
FROM VENDRE
GROUP BY ANNEE, Numero_Ticket
HAVING SUM(QUANTITE) < 50
ORDER BY SUM(QUANTITE) ASC;


-- Question 13
-- Lister chaque ticket pour lequel la quantité totale d'articles vendus est supérieure à 500. (Classer par quantité décroissante)

SELECT ANNEE, Numero_Ticket, SUM(QUANTITE) AS QuantitéTotale
FROM VENDRE
GROUP BY ANNEE, Numero_Ticket
HAVING SUM(QUANTITE) > 500
ORDER BY SUM(QUANTITE) DESC;

-- Question 14
--Lister chaque ticket pour lequel la quantité totale d'articles vendus est supérieure à 500. On exclura du total, les ventes de 50 articles et plus. (classer par quantité décroissante)

SELECT ANNEE, Numero_Ticket, SUM(QUANTITE) AS QuantitéTotale
FROM VENDRE
GROUP BY ANNEE, Numero_Ticket
HAVING SUM(QUANTITE) > 500  
AND SUM(QUANTITE) - SUM(CASE WHEN QUANTITE >= 50 THEN QUANTITE ELSE 0 END) > 0
ORDER BY SUM(QUANTITE) DESC;


-- Question 15
--Lister les bières de type ‘Trappiste'. (id, nom de la bière, volume et titrage)

SELECT A.ID_ARTICLE AS Code, A.NOM_ARTICLE AS Nom, A.VOLUME, A.TITRAGE
FROM ARTICLE A
INNER JOIN TYPEBIERE T ON A.ID_TYPE = T.ID_TYPE
WHERE T.NOM_TYPE = 'Trappiste';


-- Question 16
--Lister les marques du continent ‘Afrique'. (id et nom de marque, nom du continent)
SELECT Marque.ID_MARQUE, Marque.NOM_MARQUE, Continent.NOM_CONTINENT
FROM Marque
INNER JOIN Pays ON Marque.ID_PAYS = Pays.ID_PAYS
INNER JOIN Continent ON Pays.ID_CONTINENT = Continent.ID_CONTINENT
WHERE Continent.NOM_CONTINENT = 'Afrique';

-- Question 17
--Lister les bières du continent ‘Afrique'. (ID, Nom et volume)

SELECT A.ID_ARTICLE AS ID, A.NOM_ARTICLE AS Nom, A.VOLUME
FROM ARTICLE A
INNER JOIN MARQUE M ON A.ID_MARQUE = M.ID_MARQUE
INNER JOIN PAYS P ON M.ID_PAYS = P.ID_PAYS
INNER JOIN CONTINENT C ON P.ID_CONTINENT = C.ID_CONTINENT
WHERE C.NOM_CONTINENT = 'Afrique';

-- Question 18
-- Lister les tickets (année, numéro de ticket, montant total à payer). En sachant que :
-- on applique un taux de TVA de 20% au montant total hors taxe de chaque ticket
-- Classer par montant décroissant :

SELECT TICKET.ANNEE, TICKET.NUMERO_TICKET, SUM(VENDRE.PRIX_VENTE * VENDRE.QUANTITE * 1.2) AS MONTANT_TOTAL_A_PAYER
FROM VENDRE
INNER JOIN TICKET ON VENDRE.NUMERO_TICKET = TICKET.NUMERO_TICKET AND VENDRE.ANNEE = TICKET.ANNEE
GROUP BY TICKET.ANNEE, TICKET.NUMERO_TICKET
ORDER BY MONTANT_TOTAL_A_PAYER DESC;


-- Question 19
--Donner le C.A. par année. (Année et Total HT)

SELECT YEAR(DATE_VENTE) AS ANNEE, SUM(PRIX_VENTE*QUANTITE) AS TOTAL_HT
FROM TICKET
JOIN VENDRE ON TICKET.NUMERO_TICKET = VENDRE.NUMERO_TICKET
GROUP BY YEAR(DATE_VENTE)
ORDER BY ANNEE;


-- Question 20
--Lister les quantités vendues de chaque article pour l'année 2017. (Id et nom de l'article, quantité vendue)

SELECT A.ID_ARTICLE AS ID, A.NOM_ARTICLE AS Nom, SUM(VENDRE.QUANTITE) AS QuantitéVendue
FROM ARTICLE A
INNER JOIN VENDRE ON A.ID_ARTICLE = VENDRE.ID_ARTICLE
INNER JOIN TICKET ON VENDRE.NUMERO_TICKET = TICKET.NUMERO_TICKET AND VENDRE.ANNEE = TICKET.ANNEE
WHERE YEAR(DATE_VENTE) = 2017
GROUP BY A.ID_ARTICLE, A.NOM_ARTICLE
ORDER BY A.ID_ARTICLE;


SELECT Article.ID_ARTICLE, Article.NOM_ARTICLE, SUM(Vendre.QUANTITE) AS QUANTITE_VENDUE
FROM Vendre
INNER JOIN Ticket ON Vendre.NUMERO_TICKET = Ticket.NUMERO_TICKET
INNER JOIN Article ON Vendre.ID_ARTICLE = Article.ID_ARTICLE
WHERE YEAR(Ticket.DATE_VENTE) = 2017
GROUP BY Article.ID_ARTICLE, Article.NOM_ARTICLE;


-- Question 21
--Lister les quantités vendues de chaque article pour les années 2014,2015 ,2016,2017.

SELECT A.ID_ARTICLE, A.NOM_ARTICLE, 
SUM(CASE WHEN YEAR(T.DATE_VENTE) = 2014 THEN V.QUANTITE ELSE 0 END) AS QTE_2014,
SUM(CASE WHEN YEAR(T.DATE_VENTE) = 2015 THEN V.QUANTITE ELSE 0 END) AS QTE_2015,
SUM(CASE WHEN YEAR(T.DATE_VENTE) = 2016 THEN V.QUANTITE ELSE 0 END) AS QTE_2016,
SUM(CASE WHEN YEAR(T.DATE_VENTE) = 2017 THEN V.QUANTITE ELSE 0 END) AS QTE_2017
FROM ARTICLE A
INNER JOIN VENDRE V ON A.ID_ARTICLE = V.ID_ARTICLE
INNER JOIN TICKET T ON V.NUMERO_TICKET = T.NUMERO_TICKET
WHERE YEAR(T.DATE_VENTE) IN (2014, 2015, 2016, 2017)
GROUP BY A.ID_ARTICLE, A.NOM_ARTICLE;


-- Question 22
--Lister les tickets sur lesquels apparaissent un des articles apparaissant aussi sur le ticket 2017-5123. (Anne et Numéro de ticket)

SELECT DISTINCT ANNEE, Numero_Ticket
FROM VENDRE
WHERE ID_ARTICLE IN (SELECT ID_ARTICLE
FROM VENDRE
WHERE ANNEE = 2017 AND Numero_Ticket = 5123);



-- Question 23
--Donner pour chaque Type de bière, la bière la plus vendue en 2017. (Classer par quantité décroissante)

SELECT TB.NOM_TYPE, A.NOM_ARTICLE, SUM(V.QUANTITE) AS QUANTITE_VENDUE
FROM VENDRE V
INNER JOIN ARTICLE A ON V.ID_ARTICLE = A.ID_ARTICLE
INNER JOIN TYPEBIERE TB ON A.ID_TYPE = TB.ID_TYPE
INNER JOIN TICKET T ON V.NUMERO_TICKET = T.NUMERO_TICKET
WHERE YEAR(T.DATE_VENTE) = 2017
GROUP BY TB.ID_TYPE, A.NOM_ARTICLE
HAVING SUM(V.QUANTITE) = (
    SELECT MAX(SUM_V.QUANTITE_VENDUE) AS MAX_QUANTITE_VENDUE
    FROM (
        SELECT A2.ID_TYPE, A2.NOM_ARTICLE, SUM(V2.QUANTITE) AS QUANTITE_VENDUE
        FROM VENDRE V2
        INNER JOIN ARTICLE A2 ON V2.ID_ARTICLE = A2.ID_ARTICLE
        INNER JOIN TYPEBIERE TB2 ON A2.ID_TYPE = TB2.ID_TYPE
        INNER JOIN TICKET T2 ON V2.NUMERO_TICKET = T2.NUMERO_TICKET
        WHERE YEAR(T2.DATE_VENTE) = 2017
        GROUP BY A2.ID_ARTICLE
    ) AS SUM_V
    WHERE SUM_V.ID_TYPE = TB.ID_TYPE
)
ORDER BY TB.NOM_TYPE, QUANTITE_VENDUE DESC;


-- Question 24
--Donner la liste des bières qui n'ont pas été vendues en 2014 ni en 2015. (Id, nom et volume)

SELECT A.ID_ARTICLE, A.NOM_ARTICLE, A.VOLUME
FROM ARTICLE A
WHERE A.ID_ARTICLE NOT IN (
    SELECT V.ID_ARTICLE
    FROM VENDRE V
    INNER JOIN TICKET T ON V.NUMERO_TICKET = T.NUMERO_TICKET
    WHERE YEAR(T.DATE_VENTE) IN (2014, 2015)
)
ORDER BY A.ID_ARTICLE;


SELECT A.ID_ARTICLE, A.NOM_ARTICLE, A.VOLUME
FROM ARTICLE A
LEFT JOIN (
    SELECT V.ID_ARTICLE
    FROM VENDRE V
    INNER JOIN TICKET T ON V.NUMERO_TICKET = T.NUMERO_TICKET
    WHERE YEAR(T.DATE_VENTE) IN (2014, 2015)
) AS VENDUES ON A.ID_ARTICLE = VENDUES.ID_ARTICLE
WHERE VENDUES.ID_ARTICLE IS NULL
ORDER BY A.ID_ARTICLE;



-- Question 25
--Donner la liste des bières qui n'ont pas été vendues en 2014 mais ont été vendues en 2015. (Id, nom et volume)

SELECT A.ID_ARTICLE, A.NOM_ARTICLE, A.VOLUME
FROM ARTICLE A
WHERE A.ID_ARTICLE IN (
    SELECT V.ID_ARTICLE
    FROM VENDRE V
    INNER JOIN TICKET T ON V.NUMERO_TICKET = T.NUMERO_TICKET
    WHERE YEAR(T.DATE_VENTE) = 2015
)
AND A.ID_ARTICLE NOT IN (
    SELECT V.ID_ARTICLE
    FROM VENDRE V
    INNER JOIN TICKET T ON V.NUMERO_TICKET = T.NUMERO_TICKET
    WHERE YEAR(T.DATE_VENTE) = 2014
)
ORDER BY A.ID_ARTICLE;




SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME
FROM ARTICLE
WHERE ID_ARTICLE IN (
    SELECT V.ID_ARTICLE
    FROM VENDRE V
    INNER JOIN TICKET T ON V.NUMERO_TICKET = T.NUMERO_TICKET
    WHERE YEAR(T.DATE_VENTE) = 2015
)
AND ID_ARTICLE NOT IN (
    SELECT V.ID_ARTICLE
    FROM VENDRE V
    INNER JOIN TICKET T ON V.NUMERO_TICKET = T.NUMERO_TICKET
    WHERE YEAR(T.DATE_VENTE) = 2014
)
ORDER BY ID_ARTICLE;


SELECT A.ID_ARTICLE, A.NOM_ARTICLE, A.VOLUME
FROM ARTICLE A
