/*
It occurs when try to move datafile from one OS path to another path in Oracle 11g

Reason the face this error is oracle db instance not in archive log mode

*/


--Solution
--set sid to related instance
export ORACLE_SID=archdb



sqlplus / as sysdba
--control 
select name from v$database;

NAME
---------
archdb


SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.


SQL> Startup mount



Total System Global Area 4008546304 bytes
Fixed Size		    2259440 bytes
Variable Size		 1308624400 bytes
Database Buffers	 2684354560 bytes
Redo Buffers		   13307904 bytes
Database mounted.



SQL> Alter database archivelog;

Database altered.


SQL> alter database open;

Database altered.


alter database  datafile '/data/oraclearchdatabase/archdb/users15.dbf' OFFLINE;

--OS
-- mv  /data/oraclearchdatabase/archdb/users15.dbf  /u01/app/oracle/archdb/users015.dbf

Alter database rename file '/data/oraclearchdatabase/archdb/users15.dbf' to '/u01/app/oracle/archdb/users015.dbf';

ALTER DATABASE RECOVER DATAFILE '/u01/app/oracle/archdb/users015.dbf';

ALTER DATABASE  DATAFILE '/u01/app/oracle/archdb/users015.dbf' online;


