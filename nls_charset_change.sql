/*
Before start this process, you need to take database backup because this process can cause corruption.

*/

SQL> conn / as sysdba
Connected to an idle instance.
SQL> startup restrict;
ORACLE instance started.

Total System Global Area 1.0536E+10 bytes
Fixed Size                  2935416 bytes
Variable Size            1.0435E+10 bytes
Database Buffers           67108864 bytes
Redo Buffers               30617600 bytes
Database mounted.
Database opened.

SELECT * FROM NLS_DATABASE_PARAMETERS 
where parameter='NLS_CHARACTERSET';
PARAMETER                                VALUE                         ---------------------------------------- ------------------------------   
NLS_CHARACTERSET                         WE8MSWIN1252

SQL> ALTER DATABASE CHARACTER SET INTERNAL_USE AL32UTF8;

Database altered.

SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> conn / as sysdba
Connected to an idle instance.
SQL> startup
ORACLE instance started.

Total System Global Area 1.0536E+10 bytes
Fixed Size                  2935416 bytes
Variable Size            1.0435E+10 bytes
Database Buffers           67108864 bytes
Redo Buffers               30617600 bytes
Database mounted.
Database opened.

SELECT * FROM NLS_DATABASE_PARAMETERS 
where parameter='NLS_CHARACTERSET';
PARAMETER                                VALUE                                                     
---------------------------------------- ------------------------------   
NLS_CHARACTERSET                         AL32UTF8
