--ORACLE RMAN BACKUP

--In default it stores in FRA

/*

2 major types of backup
	1-Full Backups
	RMAN copy each data block which contains data
	
	2-Incremental Backups
	Only copies data block which changes last backup.
	It has two types of Incremental Backup
	Backup types of Incremental Backup
	Level 0: full backup
	Level 1: Cumulative and differential
	
		2.1- Level 0
		Full backup
		
		2.2- Level 1 
			2.2.1- Level 1 Cumulative Backup
			It backsup change data from last incremental backups
		



*/


oracle@localhost:/u01]# export TWO_TASK=
[oracle@localhost:/u01]# echo $ORACLE_SID
testdb
[oracle@localhost:/u01]# rman target=/

Recovery Manager: Release 12.2.0.1.0 - Production on Tue Nov 12 17:56:50 2019

Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.

connected to target database: TESTDB (DBID=2807463263)

RMAN> show all
2> ;

using target database control file instead of recovery catalog
RMAN configuration parameters for database with db_unique_name TESTDB are:
CONFIGURE RETENTION POLICY TO REDUNDANCY 1; # default      --
CONFIGURE BACKUP OPTIMIZATION OFF; # default
CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default      -- when runnıng rman create file in disk
CONFIGURE CONTROLFILE AUTOBACKUP ON; # default		  -- 
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE MAXSETSIZE TO UNLIMITED; # default
CONFIGURE ENCRYPTION FOR DATABASE OFF; # default
CONFIGURE ENCRYPTION ALGORITHM 'AES128'; # default
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE ; # default
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; # default
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE; # default
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/u01/app/oracle/product/12.2.0/db_1/dbs/snapcf_testdb.f'; # default

--rman keep backup 7 days
RMAN> configure retention policy to recovery window of 7 days;  

new RMAN configuration parameters:
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;
new RMAN configuration parameters are successfully stored

--location to store RMAN backups in directory

/*
%d= database name
%I= database id
%T= time
%U= system generated unique file name

*/
RMAN> configure channel device type disk format '/u01/fra/backups/%d_%I_%T_%U';

new RMAN configuration parameters:
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT   '/u01/fra/backups/%d_%I_%T_%U';
new RMAN configuration parameters are successfully stored


-- clear command delete related configuration
RMAN> configure channel device type disk clear;

old RMAN configuration parameters:
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT   '/u01/fra/backups/%d_%I_%T_%U';
old RMAN configuration parameters are successfully deleted
