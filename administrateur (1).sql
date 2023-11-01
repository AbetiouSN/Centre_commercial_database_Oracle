-------------------
---------------29/10/2023-------



-- creation des roles et vues ... 

----------------------------------------
-----------DEPARTEMENT Administration---------------
----------------------------------------

ALTER SESSION SET"_ORACLE_SCRIPT"=TRUE;
conn ADMINST1/ADMINST1
-- CREATION USERS : USER1 = ADMINST1
CREATE USER ADMINST1 IDENTIFIED BY ADMINST1 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP QUOTA UNLIMITED ON USERS ACCOUNT UNLOCK;
-- CREATION USERS : USER2 = SECR
CREATE USER SECR IDENTIFIED BY SECR DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP QUOTA UNLIMITED ON USERS ACCOUNT UNLOCK;

-- PRIVILEGES POUR LES UTILISATEURS 

GRANT CONNECT , RESOURCE,create table,create view,create role  TO ADMINST1;
GRANT CONNECT , RESOURCE TO SECR;

------------------------------------------
----------Creation des tables-----------
----------------------------------------
conn ADMINST1/ADMINST1
               --depar.RH-----
               CREATE TABLE Employes (
               EmployeID INT PRIMARY KEY,
               Nom VARCHAR(50),
               Prenom VARCHAR(50),
               DateNaissance DATE,
               Adresse VARCHAR(100),
               Email VARCHAR(100),
               Telephone VARCHAR(15)
               );

               -- Table des emplois
               CREATE TABLE Emplois (
               EmploiID INT PRIMARY KEY,
               Titre VARCHAR(50),
               Description VARCHAR(50),
               Salaire DECIMAL(10, 2),
               DateEmbauche DATE,
               Departement VARCHAR(50),
               ResponsableID INT,
               FOREIGN KEY (ResponsableID) REFERENCES Employes(EmployeID)
               );
               --depart.achat---
               -- TABLE DES CLIENTS 
               CREATE TABLE CLIENTS (
               clientID INT PRIMARY KEY,
               Nom VARCHAR(50),
               Prenom VARCHAR(50),
               DateNaissance DATE,
               Adresse VARCHAR(100),
               Email VARCHAR(100),
               Telephone VARCHAR(15)
               );

               --produit
               CREATE TABLE PRODUIT (
               ProduitID INT PRIMARY KEY,
               Nom VARCHAR(50),
               QUANTITE INT,
               prix NUMBER
               );

               --commande
               CREATE TABLE COMMANDE (
               PRODUIT_ID INT,
               CLIENT_ID INT,
               FOREIGN KEY (PRODUIT_ID) REFERENCES PRODUIT(ProduitID),
               FOREIGN KEY (CLIENT_ID) REFERENCES CLIENTS(clientID)
               );
-------------------la vue de l'administrateur sur la commande du client d'un produit--
CREATE OR REPLACE VIEW VueCommandes AS
SELECT
    C.Nom AS Nom_Client,
    P.Nom AS Nom_Produit
FROM
    COMMANDE CMD
    INNER JOIN CLIENTS C ON CMD.CLIENT_ID = C.clientID
    INNER JOIN PRODUIT P ON CMD.PRODUIT_ID = P.ProduitID;


---------------------------------------------
-------------------creation des roles---------
----------------------------------------------
       
         --ces role sont cree dans la session administrateur--
create role RSECR;
create role RRH;
create role RVRH;
create role RACHAT;
create role Rcaissier;
create role Rclient;



               ---------------------------------------------
               -------------------departement Direction-----
               ---------------------------------------------
               

------ la secretaire a une visualizaton sur employer et leur emploie--
----1er etape creation d'une vue-------
CREATE VIEW Vue_EmployeEmploi AS
SELECT E.Nom, E.Prenom, E.Adresse, Emp.Titre, Emp.Departement
FROM Employes E
JOIN Emplois Emp ON E.EmployeID = Emp.ResponsableID;

 ------moment d'attribution du privilege
 grant select on Vue_EmployeEmploi to Rsecr;
 grant Rsecr to SECR;
  -------- 
      -----teste
           conn secr/SECR
           select * from ADMINST1.Vue_EmployeEmploi;
       ------
   ----------

   ----------------------------------
   ----------------RH---------------
   grant all on Employes  to RRH;
   grant all on emplois to RRH;
   grant RRH to RESPO_RH;
   grant select on Vue_EmployeEmploi to RESPO_RH with grant option;
   ---3titha nichan utilisateur cause grant objet matat3tch el role


GRANT CONNECT , RESOURCE TO client;




































-- Client 1
INSERT INTO CLIENTS (clientID, Nom, Prenom, DateNaissance, Adresse, Email, Telephone)
VALUES (1, 'Doe', 'John', TO_DATE('1990-01-15', 'YYYY-MM-DD'), '123 Main Street', 'john.doe@email.com', '555-123-4567');

-- Client 2
INSERT INTO CLIENTS (clientID, Nom, Prenom, DateNaissance, Adresse, Email, Telephone)
VALUES (2, 'Smith', 'Jane', TO_DATE('1985-07-25', 'YYYY-MM-DD'), '456 Elm Street', 'jane.smith@email.com', '555-987-6543');

-- Client 3
INSERT INTO CLIENTS (clientID, Nom, Prenom, DateNaissance, Adresse, Email, Telephone)
VALUES (3, 'Dupont', 'Marie', TO_DATE('1988-05-20', 'YYYY-MM-DD'), '789 Oak Avenue', 'marie.dupont@email.com', '555-222-3333');

-- Client 4
INSERT INTO CLIENTS (clientID, Nom, Prenom, DateNaissance, Adresse, Email, Telephone)
VALUES (4, 'Garcia', 'Carlos', TO_DATE('1995-11-10', 'YYYY-MM-DD'), '456 Pine Street', 'carlos.garcia@email.com', '555-777-8888');
