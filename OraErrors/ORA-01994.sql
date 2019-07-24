/*
ORA-01994:
Poblem here was the orapwd file created with upper case ORACLE_SID but the actual instance name is setted with lower case.
In order solve this problem we need to create new oracle password file with using orapwd utility.

*/

SQL> grant sysdba to bbenzerdba;
grant sysdba to bbenzerdba
*
ERROR at line 1:
ORA-01994: GRANT failed: password file missing or disabled



dbs]$ orapwd file=/u01/app/oracle/product/11.2.0/db_1/dbs/orapw$ORACLE_SID password=oracle entries=10


SQL> grant sysdba to bbenzerdba;

Grant succeeded..


 
