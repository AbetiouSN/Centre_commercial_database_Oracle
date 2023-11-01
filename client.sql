conn ADMINST1/ADMINST1
CREATE ROLE Rclient;
ALTER SESSION SET"_ORACLE_SCRIPT"=TRUE;
conn sys as sysdba
GRANT CONNECT, RESOURCE TO CLIENT;
----afectationdu role au user
conn ADMINST1/ADMINST1
GRANT RCLIENT TO CLIENT;

ALTER SESSION SET"_ORACLE_SCRIPT"=TRUE;


---check option pour lui bloquer toute tentative de malveillance d'acceder au autre enregirtrement d
---de cet view

-- Grant privileges on views
---administ1
GRANT SELECT ON VueCommandesClient TO uachat with grant option;
----uaachat
GRANT SELECT ON ADMINST1.VueCommandesClient TO RCLIENT ;

-- -- Grant privileges on tables for Rcaissier role
--GRANT SELECT ON PRODUIT TO RCLIENT;