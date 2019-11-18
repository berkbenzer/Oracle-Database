

--STANDBY DATABASE
SQL> select max(sequence#) from v$log_history;

--MAX(SEQUENCE#)
--------------
--	  4674

SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;

--Database altered.

SQL> SELECT CURRENT_SCN FROM V$DATABASE;

--CURRENT_SCN
-----------
--   33538563

SQL> select min(fhscn) from x$kcvfh;

--MIN(FHSCN)
----------------
--33538564


--ON PRIMARY DATABASE

SQL> select max(sequence#) from v$log_history;

--MAX(SEQUENCE#)
--------------
--	  6384


--ON PRIMARY DATABASE
:/tmp]# rman

Recovery Manager: Release 11.2.0.4.0 - Production on Mon Oct 21 10:44:34 2019

Copyright (c) 1982, 2011, Oracle and/or its affiliates.  All rights reserved.

RMAN> connect target /

connected to target database: XXXX (DBID=234748998)

RMAN> BACKUP INCREMENTAL FROM SCN 33538563 DATABASE FORMAT '/tmp/ForStandby_%U' tag 'FORSTANDBY'

RMAN> BACKUP CURRENT CONTROLFILE FOR STANDBY FORMAT '/tmp/ForStandbyyCTRL.bck';



--send backup files to standayby db or dr machine

scp /tmp/ForStandby_* standby:/tmp


--ON STANDBY DATABASE
RMAN> recover database noredo;

Starting recover at 21-OCT-19
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=502 device type=DISK
channel ORA_DISK_1: starting incremental datafile backup set restore
channel ORA_DISK_1: specifying datafile(s) to restore from backup set
destination for restore of datafile 00001: /u01/app/oracle/oradata/xxx/system01.dbf
destination for restore of datafile 00002: /u01/app/oracle/oradata/xxx/sysaux01.dbf
destination for restore of datafile 00003: /u01/app/oracle/oradata/xxx/undotbs01.dbf
destination for restore of datafile 00004: /u01/app/oracle/oradata/xxx/users01.dbf
destination for restore of datafile 00005: /u01/app/oracle/oradata/xxx/xxx01.dbf
channel ORA_DISK_1: reading from backup piece /tmp/ForStandby_76ues4j3_1_1
RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03002: failure of recover command at 10/21/2019 10:50:30
ORA-19870: error while restoring backup piece /tmp/ForStandby_76ues4j3_1_1
ORA-19573: cannot obtain exclusive enqueue for datafile 1




SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.



SQL> startup mount;
ORACLE instance started.

Total System Global Area  271437824 bytes
Fixed Size		    2252336 bytes
Variable Size		  213909968 bytes
Database Buffers	   50331648 bytes
Redo Buffers		    4943872 bytes
Database mounted.



RMAN> recover database noredo;

Starting recover at 21-OCT-19
using target database control file instead of recovery catalog
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=74 device type=DISK
channel ORA_DISK_1: starting incremental datafile backup set restore
channel ORA_DISK_1: specifying datafile(s) to restore from backup set
destination for restore of datafile 00001: /u01/app/oracle/oradata/xxx/system01.dbf
destination for restore of datafile 00002: /u01/app/oracle/oradata/xxx/sysaux01.dbf
destination for restore of datafile 00003: /u01/app/oracle/oradata/xxx/undotbs01.dbf
destination for restore of datafile 00004: /u01/app/oracle/oradata/xxx/users01.dbf
destination for restore of datafile 00005: /u01/app/oracle/oradata/xxx/xxx01.dbf
channel ORA_DISK_1: reading from backup piece /tmp/ForStandby_76ues4j3_1_1
channel ORA_DISK_1: piece handle=/tmp/ForStandby_76ues4j3_1_1 tag=FORSTANDBY
channel ORA_DISK_1: restored backup piece 1
channel ORA_DISK_1: restore complete, elapsed time: 00:00:35

Finished recover at 21-OCT-19





RMAN> shutdown;
RMAN> startup nomount;
/*
connected to target database (not started)
Oracle instance started

Total System Global Area     271437824 bytes

Fixed Size                     2252336 bytes
Variable Size                213909968 bytes
Database Buffers              50331648 bytes
Redo Buffers                   4943872 bytes


using target database control file instead of recovery catalog
database dismounted
Oracle instance shut down

*/

RMAN> RESTORE STANDBY CONTROLFILE FROM '/tmp/ForStandbyCTRL.bck';

--ON PRIMARY

SQL> select max(sequence#) from v$log_history;

MAX(SEQUENCE#)
--------------
	  6386



--ON STANDBY 

SQL> select max(sequence#) from v$log_history;

MAX(SEQUENCE#)
--------------
	  6386

