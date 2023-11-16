-- Connexion en tant qu'administrateur
CONN SYS as SYSDBA;

-- Activation des scripts Oracle
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

----------------------------------------
-- Création des utilisateurs et attribution des rôles
----------------------------------------

-- Utilisateur ADMINST1
CREATE USER ADMINST1 IDENTIFIED BY ADMINST1 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP QUOTA UNLIMITED ON USERS ACCOUNT UNLOCK;
GRANT CONNECT, RESOURCE, CREATE TABLE, CREATE VIEW, CREATE ROLE TO ADMINST1;

-- Utilisateur SECR
CREATE USER SECR IDENTIFIED BY SECR DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP QUOTA UNLIMITED ON USERS ACCOUNT UNLOCK;
GRANT CONNECT, RESOURCE TO SECR;

-- Attribution des rôles spécifiques
CREATE ROLE RSECR;
CREATE ROLE RRH;
CREATE ROLE RVRH;
CREATE ROLE RACHAT;
CREATE ROLE Rcaissier;
CREATE ROLE Rclient;

GRANT RSECR TO SECR;

----------------------------------------
-- Création des tables
----------------------------------------

-- Table pour le département RH
CREATE TABLE Employes (
    EmployeID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    DateNaissance DATE,
    Adresse VARCHAR(100),
    Email VARCHAR(100),
    Telephone VARCHAR(15)
);

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

-- Table pour le département Achat
CREATE TABLE CLIENTS (
    clientID INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    DateNaissance DATE,
    Adresse VARCHAR(100),
    Email VARCHAR(100),
    Telephone VARCHAR(15)
);

CREATE TABLE PRODUIT (
    ProduitID INT PRIMARY KEY,
    Nom VARCHAR(50),
    QUANTITE INT,
    prix NUMBER
);

CREATE TABLE COMMANDE (
    PRODUIT_ID INT,
    CLIENT_ID INT,
    FOREIGN KEY (PRODUIT_ID) REFERENCES PRODUIT(ProduitID),
    FOREIGN KEY (CLIENT_ID) REFERENCES CLIENTS(clientID)
);

----------------------------------------
-- Création des vues
----------------------------------------

-- Vue pour l'administrateur sur les commandes clients
CREATE OR REPLACE VIEW VueCommandes AS
SELECT
    C.Nom AS Nom_Client,
    P.Nom AS Nom_Produit
FROM
    COMMANDE CMD
    INNER JOIN CLIENTS C ON CMD.CLIENT_ID = C.clientID
    INNER JOIN PRODUIT P ON CMD.PRODUIT_ID = P.ProduitID;

-- Vue pour la secrétaire sur les employés et leurs emplois
CREATE OR REPLACE VIEW Vue_EmployeEmploi AS
SELECT E.Nom, E.Prenom, E.Adresse, Emp.Titre, Emp.Departement
FROM Employes E
JOIN Emplois Emp ON E.EmployeID = Emp.ResponsableID;

----------------------------------------
-- Attribution des privilèges et rôles
----------------------------------------

-- Secrétaire
GRANT SELECT ON Vue_EmployeEmploi TO RSECR;
GRANT RSECR TO SECR;

-- Ressources Humaines
GRANT ALL ON Employes TO RRH;
GRANT ALL ON Emplois TO RRH;
GRANT RRH TO RESPO_RH;
GRANT SELECT ON Vue_EmployeEmploi TO RESPO_RH WITH GRANT OPTION;

-- Utilisateur client
GRANT CONNECT, RESOURCE TO client;

-- Insertion de données pour les clients
INSERT INTO CLIENTS VALUES
    (1, 'Doe', 'John', TO_DATE('1990-01-15', 'YYYY-MM-DD'), '123 Main Street', 'john.doe@email.com', '555-123-4567'),
    (2, 'Smith', 'Jane', TO_DATE('1985-07-25', 'YYYY-MM-DD'), '456 Elm Street', 'jane.smith@email.com', '555-987-6543'),
    (3, 'Dupont', 'Marie', TO_DATE('1988-05-20', 'YYYY-MM-DD'), '789 Oak Avenue', 'marie.dupont@email.com', '555-222-3333'),
    (4, 'Garcia', 'Carlos', TO_DATE('1995-11-10', 'YYYY-MM-DD'), '456 Pine Street', 'carlos.garcia@email.com', '555-777-8888');
