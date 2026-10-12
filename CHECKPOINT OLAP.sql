CREATE TABLE Clients (
Id_client INT PRIMARY KEY NOT NULL,
Ville VARCHAR(50) NOT NULL,
Region VARCHAR(50) NOT NULL,
Pays VARCHAR(50) NOT NULL
);
INSERT INTO Clients 
    VALUES
     (1,'Lola', 'Nzerekore', 'Guinee'),
     (2,'Pita', 'Labe', 'Guinee'),
     (3,'Boudiali', 'Khorogo', 'Côte d"Ivoire'),
     (4,'Kalma', 'Segou', 'Mali'),
     (5,'Souple', 'Man', 'Côte d"Ivoire')
    
SELECT * FROM Clients

CREATE TABLE Produits (
Id_produit INT PRIMARY KEY NOT NULL,
Nom_Prod VARCHAR(50) NOT NULL,
Categorie VARCHAR(50) NOT NULL,
Prix_Revien DECIMAL(10, 2) NOT NULL,
Prix_Achat DECIMAL(10, 2)
);
ALTER TABLE Produits ADD Fourniseurs VARCHAR(50)
Update Produits SET Fourniseurs =  'Mr. Abou' WHERE Id_produit = 10;
Update Produits SET Fourniseurs =  'Mr. Fode' WHERE Id_produit = 20;
Update Produits SET Fourniseurs =  'Mm Fanta' WHERE Id_produit = 30;
Update Produits SET Fourniseurs =  'Mr. Sekou' WHERE Id_produit = 40;
Update Produits SET Fourniseurs =  'Mm Mariame' WHERE Id_produit = 50;

INSERT INTO Produits 
    VALUES
     (10,'Orange', 'Fruits', 250.00, 150.00),
     (20,'Igname', 'Tubercule', 450.00, 270.00),
     (30,'Banane', 'Fruits', 300.00, 250.00),
     (40,'Riz', 'Cereale', 500.00, 320.00),
     (50,'Fonioh', 'Cereale', 450.00, 320.00)

 SELECT * FROM Produits 

CREATE TABLE Dates (
Id_date INT PRIMARY KEY NOT NULL,
Mois VARCHAR(50) NOT NULL,
Trimestre VARCHAR(50) NOT NULL,
Annee INT NOT NULL
);
INSERT INTO Dates 
    VALUES
       (101,'Janvier', 'T1', 2024),
       (102,'Juin', 'T2', 2024),
       (103,'Mars', 'T3', 2025),
       (104,'Aout', 'T4', 2025),
       (105,'Septembre', 'T5', 2025)

SELECT * FROM Dates

CREATE TABLE Ventes (
Id_vente INT PRIMARY KEY NOT NULL, 
Id_produit INT NOT NULL, FOREIGN KEY (Id_produit) REFERENCES Produits (Id_produit),
Id_date INT NOT NULL, FOREIGN KEY (Id_date) REFERENCES Dates (Id_date),
Id_client INT NOT NULL, FOREIGN KEY (Id_client) REFERENCES Clients (Id_client),
Date_livraison DATE NOT NULL,
Quantite INT NOT NULL
);

ALTER TABLE Ventes
DROP COLUMN Id_vente;

INSERT INTO Ventes 
    VALUES
       (1001, 10, 101, 1, '01-01-2024', 105),
       (1002, 20, 102, 2, '19-02-2024', 95),
       (1003, 30, 103, 3, '20-03-2025', 115),
       (1004, 40, 104, 4, '29-07-2025', 75),
       (1005, 50, 105, 5, '30-09-2025', 1002)

SELECT * FROM Ventes;

SELECT v.Id_vente, p.Nom_prod, p.Categorie, p.Prix_Revien, v.Quantite, p.Prix_Achat, SUM(Prix_achat) * SUM(Quantite) AS Montant FROM Ventes v
INNER JOIN Produits p
ON v.Id_produit = p.Id_produit
GROUP BY v.Id_vente, p.Nom_prod, p.Categorie, p.Prix_Revien, v.Quantite, p.Prix_Achat;

--===========================================================================================
-- / 1. Écrire une requête pour calculer le montant total des ventes par pays./
--===========================================================================================

SELECT C.Pays, SUM(Prix_achat) * SUM(Quantite) AS Montant_Total FROM Ventes v
INNER JOIN Produits p
ON v.Id_produit = p.Id_produit
INNER JOIN Clients C
ON C.Id_client = v.Id_client
GROUP BY (C.Pays);

--=======================================================================================================================================
---/2. Écrire une requête pour calculer le montant total des ventes par mois de chaque année, puis par année, et enfin le total général./
--=======================================================================================================================================

SELECT da.Annee, da.Mois, SUM(Prix_achat) * SUM(Quantite) AS Montant_Total FROM Ventes v
INNER JOIN Produits p
ON v.Id_produit = p.Id_produit
INNER JOIN Dates da
ON da.Id_date = v.Id_date
GROUP BY CUBE (da.Annee, da.Mois);

--==================================================================================================
--/3. Écrivez une requête pour calculer les quantités du produit « RIZ » vendues :/

   --- Par pays,  

   --- Par année,  

   --- Par année pour chaque pays,  

---Et le total général./
--==================================================================================================

SELECT C.Pays, da.Annee, SUM(Quantite) AS Quantite_Total FROM Ventes v
INNER JOIN Clients C
ON v.Id_client = C.Id_client
INNER JOIN Produits p
ON v.Id_produit = p.Id_produit
INNER JOIN Dates da
ON da.Id_date = v.Id_date
WHERE 
Nom_Prod = 'Riz'
GROUP BY GROUPING SETS ( (Pays), (Annee), (Annee, Pays), ());

SELECT C.Pays, da.Annee, SUM(Quantite) AS Quantite_Total FROM Ventes v
INNER JOIN Clients C
ON v.Id_client = C.Id_client
INNER JOIN Produits p
ON v.Id_produit = p.Id_produit
INNER JOIN Dates da
ON da.Id_date = v.Id_date
WHERE 
Nom_Prod = 'Riz'
GROUP BY CUBE (Annee, Pays);

--=======================================================================
---4. écrivez une requête pour calculer le montant total des ventes :

   --- Par pays, 

     --- Par année,  

   --- Et par produit./
   --=======================================================================

SELECT C.Pays, da.Annee, p.Nom_prod, SUM(Prix_achat) * SUM(Quantite) AS Quantite_Total FROM Ventes v
INNER JOIN Clients C
ON v.Id_client = C.Id_client
INNER JOIN Produits p
ON v.Id_produit = p.Id_produit
INNER JOIN Dates da
ON da.Id_date = v.Id_date
GROUP BY GROUPING SETS ((C.Pays), (da.Annee),(p.Nom_prod), ());