-- creation des roles et vues ... 

----------------------------------------
-----------DEPARTEMENT RH---------------
----------------------------------------
ALTER SESSION SET"_ORACLE_SCRIPT"=TRUE;
-- CREATION USERS : USER1 = RESPO_RH
CREATE USER RESPO_RH IDENTIFIED BY RERH DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP QUOTA 
UNLIMITED ON USERS ACCOUNT UNLOCK;
-- CREATION USERS : USER2 = VICE_RESPO_RH
CREATE USER VICE_RESPO_RH IDENTIFIED BY VCRERH 
DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP QUOTA 
UNLIMITED ON USERS ACCOUNT UNLOCK;

-- PRIVILEGES POUR LES UTILISATEURS 

GRANT CONNECT , RESOURCE,create view TO RESPO_RH;
GRANT CONNECT , RESOURCE TO VICE_RESPO_RH;







-----------------------------------------------------------
-------------peuplements----------------------------------
---------------------------------------------------------*
-- Insertion de données dans la table ADMINST1.Employes
INSERT INTO ADMINST1.Employes (EmployeID, Nom, Prenom, DateNaissance, Adresse, Email, Telephone)
VALUES
    (1, 'Dupont', 'Jean', TO_DATE('1980-05-10', 'YYYY-MM-DD'), '123 Rue de la Paix', 'jean.dupont@email.com', '123-456-7890');

   INSERT INTO ADMINST1.Employes (EmployeID, Nom, Prenom, DateNaissance, Adresse, Email, Telephone)
VALUES (2, 'Martin', 'Sophie', TO_DATE('1990-08-15','YYYY-MM-DD'), '456 Avenue des Roses', 'sophie.martin@email.com', '987-654-3210');
    INSERT INTO ADMINST1.Employes (EmployeID, Nom, Prenom, DateNaissance, Adresse, Email, Telephone)
VALUES(3, 'Lefebvre', 'Paul', TO_DATE('1985-02-25','YYYY-MM-DD'), '789 Boulevard du Soleil', 'paul.lefebvre@email.com', '555-123-7890');
    INSERT INTO ADMINST1.Employes (EmployeID, Nom, Prenom, DateNaissance, Adresse, Email, Telephone)
VALUES(4, 'Dubois', 'Marie', TO_DATE('1995-11-03','YYYY-MM-DD'), '567 Chemin de la Lune', 'marie.dubois@email.com', '333-888-9999');



-- Insertion de données dans la table ADMINST1.Emplois
-- Insérer des données dans la table ADMINST1.Emplois
INSERT INTO ADMINST1.Emplois (EmploiID, Titre, Description, Salaire, DateEmbauche, Departement, ResponsableID)
VALUES (1, 'Ingénieur logiciel', 'Développement de logiciels', 80000.00, TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'Développement', 1);

INSERT INTO ADMINST1.Emplois (EmploiID, Titre, Description, Salaire, DateEmbauche, Departement, ResponsableID)
VALUES (2, 'Gestionnaire de projet', 'Gestion de projets informatiques', 90000.00, TO_DATE('2021-11-20', 'YYYY-MM-DD'), 'Gestion de projets', 2);

INSERT INTO ADMINST1.Emplois (EmploiID, Titre, Description, Salaire, DateEmbauche, Departement, ResponsableID)
VALUES (3, 'Spécialiste des ressources humaines', 'Gestion des RH', 60000.00, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 'Ressources humaines', 3);

INSERT INTO ADMINST1.Emplois (EmploiID, Titre, Description, Salaire, DateEmbauche, Departement, ResponsableID)
VALUES (4, 'Analyste financier', 'Analyse des finances de lentreprise', 75000.00, TO_DATE('2022-09-05', 'YYYY-MM-DD'), 'Finance', 4);




conn RESPO_RH/RERH 
grant select on ADMINST1.Vue_EmployeEmploi 
to RVRH;
conn sys as sysdba
grant RVRH to VICE_RESPO_RH ;
conn VICE_RESPO_RH/VCRERH
-----teste de respensable RH

select * from ADMINST1.Vue_EmployeEmploi;
select * from ADMINST1.emplois;
 select * from ADMINST1.Employes;