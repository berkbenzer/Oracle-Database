
--1. Mount the database


SQL> STARTUP MOUNT
ORACLE instance started.
Total System Global Area 8754618368 bytes
Fixed Size                  4646288 bytes
Variable Size            3556776560 bytes
Database Buffers         5033164800 bytes
Redo Buffers              160030720 bytes
Database mounted.
SQL> select name,open_mode from v$database;
NAME      OPEN_MODE
--------- --------------------
B2CRMD2   MOUNTED


--2. Run the NID utility
SYNTAX – nid sys/password@CURRENT_DBNAME DBNAME=NEW_DBNAME

bash-4.1$ nid target=sys/oracle@S1D2ST DBNAME=S1D2ST

--3. change the db_name parameter in the parameter file.
SQL> shutdown immediate;
ORA-01507: database not mounted
ORACLE instance shut down.
SQL> startup nomount
ORA-32004: obsolete or deprecated parameter(s) specified for RDBMS instance
ORACLE instance started.
Total System Global Area 8754618368 bytes
Fixed Size                  4646288 bytes
Variable Size            3556776560 bytes
Database Buffers         5033164800 bytes
Redo Buffers              160030720 bytes
SQL> alter system set db_name=S1D2ST scope=spfile;
System altered.
SQL> shutdown immediate;
ORA-01507: database not mounted
ORACLE instance shut down.
SQL>
SQL>
SQL> startup nomount
ORA-32004: obsolete or deprecated parameter(s) specified for RDBMS instance
ORACLE instance started.
Total System Global Area 8754618368 bytes
Fixed Size                  4646288 bytes
Variable Size            3556776560 bytes
Database Buffers         5033164800 bytes
Redo Buffers              160030720 bytes
SQL> show parameter db_name
NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_name                              string      S1D2ST
SQL> shutdown immediate;
ORA-01507: database not mounted
ORACLE instance shut down.


--4. Rename the spfile to new db name
cp spfileB2CRMD2.ora spfileS1D2ST.ora



-bash-4.1$ export ORACLE_SID=S1D2ST
-bash-4.1$ s
SQL*Plus: Release 12.1.0.1.0 Production on Tue May 17 20:42:26 2016
Copyright (c) 1982, 2013, Oracle.  All rights reserved.
Connected to an idle instance.
SQL> startup nomount
ORA-32004: obsolete or deprecated parameter(s) specified for RDBMS instance
ORACLE instance started.
Total System Global Area 8754618368 bytes
Fixed Size                  4646288 bytes
Variable Size            3489667696 bytes
Database Buffers         5100273664 bytes
Redo Buffers              160030720 bytes
SQL> alter database mount;
Database altered.
SQL>  alter database open resetlogs;
Database altered.
SQL> show parameter local
NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
local_listener                       string      (ADDRESS_LIST=(ADDRESS=(PROTOC
                                                 OL=TCP)(HOST=xxxx)(POR
                                                 T=xx)))
log_archive_local_first              boolean     TRUE
parallel_force_local                 boolean     FALSE
SQL> alter system register;
System altered.


