---chez administrateur--
CREATE ROLE RACHAT;
CREATE ROLE Rcaissier;
---en sys--
ALTER SESSION SET"_ORACLE_SCRIPT"=TRUE;

CREATE USER UACHAT IDENTIFIED BY UACHAT DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP QUOTA UNLIMITED ON USERS ACCOUNT UNLOCK;
CREATE USER UCAISSER IDENTIFIED BY UCAISSER DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP QUOTA UNLIMITED ON USERS ACCOUNT UNLOCK;

GRANT CONNECT, RESOURCE, create view TO UACHAT;
GRANT CONNECT , RESOURCE TO UCAISSER;
-----------------------------


-- Create tables
CONN ADMINST1/ADMINST1

-- Create view for filtering commands by client
--CREATE OR REPLACE VIEW VueCommandesClient AS
--SELECT CMD.PRODUIT_ID, CMD.CLIENT_ID
---FROM COMMANDE CMD
-----jOIN CLIENTS CL ON CMD.CLIENT_ID = CL.clientID;



-- Grant privileges on tables for RACHAT role
-----chez administrateur
GRANT all ON PRODUIT TO UACHAT with grant option;
GRANT all ON CLIENTS TO RACHAT ;
GRANT all ON COMMANDE TO UACHAT with grant option;
---GRANT SELECT ON VueCommandesClient TO UACHAT with grant option;

-- Grant privileges on tables for Rcaissier role
---------le caissier----------------------
conn UACHAT/UACHAT
GRANT SELECT ON ADMINST1.PRODUIT TO Rcaissier;
GRANT SELECT, INSERT ON ADMINST1.COMMANDE TO Rcaissier;
GRANT SELECT ON ADMINST1.VueCommandes TO Rclient;


---- hadi la a sofian caissier 3NDU gha commande o produit 
--GRANT SELECT, INSERT, UPDATE, DELETE ON CLIENTS TO Rcaissier;


--------------
-----------
---on done les role
 GRANT RACHAT TO UACHAT;
GRANT Rcaissier TO UCAISSER;
