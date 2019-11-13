
--Damage the db
--delete system datafile

SQL> select file_name from dba_data_files;

FILE_NAME
--------------------------------------------------------------------------------
/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_users_gwnsk1kb_.dbf
/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_undotbs1_gwnsk0h7_.dbf
/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_system_gwnsh452_.dbf
/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_sysaux_gwnsj7dx_.dbf


~]# rm -f /u01/app/oracle/oradata/TESTDB/datafile/o1_mf_system_gwnsh452_.dbf


sqlplus / as sysdba

SQL*Plus: Release 12.2.0.1.0 Production on Tue Nov 12 20:19:12 2019

Copyright (c) 1982, 2016, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production

SQL> shutdown immediate;
ORA-01116: error in opening database file 1
ORA-01110: data file 1: '/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_system_gwnsh452_.dbf'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3

SQL> SHUTDOWN ABORT
SQL> startup;
ORACLE instance started.

Total System Global Area 3774873600 bytes
Fixed Size		    8627440 bytes
Variable Size		  872418064 bytes
Database Buffers	 2885681152 bytes
Redo Buffers		    8146944 bytes
Database mounted.
ORA-01157: cannot identify/lock data file 1 - see DBWR trace file
ORA-01110: data file 1:
'/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_system_gwnsh452_.dbf'


SQL> alter database open;
alter database open
*
ERROR at line 1:
ORA-01157: cannot identify/lock data file 1 - see DBWR trace file
ORA-01110: data file 1:
'/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_system_gwnsh452_.dbf'


~]# rman target=/
RUN
{
restore database;   	--restore database datafiles from rman backup 
recover database;		--apply redologs
alter database open;	
}

RMAN> restore database;
RMAN> recover database;
RMAN> alter database open;
Statement processed
RMAN> 
