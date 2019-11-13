--First delete all backupset 
RMAN> delete backup of database;
RMAN> delete backup of archivelog all;
RMAN> delete backup of controlfile;



sql 'alter system archive log current';

RUN
{
configure controlfile autobackup on;  
backup database tag DB_FULL format '/u01/fra/backups/DB_BACKUP_%d_%T_%s_%p_FULL';
sql 'alter system archive log current';
backup tag DB_ARCHIVE format '/u01/fra/backups/%d_%T_%s_%p_ARCHIVE' archivelog all;
backup tag ORCL_CONTROL current controlfile format '/u01/fra/backups/%d_%T_%s_%p_CONTROL';
}

quit;


:~]# vi /u01/fra/backups/backup_full.rman
sql 'alter system archive log current';

RUN
{
configure controlfile autobackup on;  
backup database tag DB_FULL format '/u01/fra/backups/DB_BACKUP_%d_%T_%s_%p_FULL';
sql 'alter system archive log current';
backup tag DB_ARCHIVE format '/u01/fra/backups/%d_%T_%s_%p_ARCHIVE' archivelog all;
backup tag ORCL_CONTROL current controlfile format '/u01/fra/backups/%d_%T_%s_%p_CONTROL';
}

~]# vi /u01/fra/backups/backup_full.rman
~]# rman target=/ @/u01/fra/backups/backup_full.rman

~]# rman target=/

Recovery Manager: Release 12.2.0.1.0 - Production on Tue Nov 12 19:48:29 2019

Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.

connected to target database: TESTDB (DBID=2807463263)

RMAN> list backup summary;

using target database control file instead of recovery catalog

List of Backups
===============
Key     TY LV S Device Type Completion Time #Pieces #Copies Compressed Tag
------- -- -- - ----------- --------------- ------- ------- ---------- ---
35      B  F  A DISK        12-NOV-19       1       1       NO         DB_FULL
36      B  F  A DISK        12-NOV-19       1       1       NO         TAG20191112T194508
37      B  A  A DISK        12-NOV-19       1       1       NO         DB_ARCHIVE
38      B  F  A DISK        12-NOV-19       1       1       NO         ORCL_CONTROL
39      B  F  A DISK        12-NOV-19       1       1       NO         TAG20191112T194513
40      B  F  A DISK        12-NOV-19       1       1       NO         DB_FULL
41      B  F  A DISK        12-NOV-19       1       1       NO         TAG20191112T194756
42      B  A  A DISK        12-NOV-19       1       1       NO         DB_ARCHIVE
43      B  F  A DISK        12-NOV-19       1       1       NO         ORCL_CONTROL
44      B  F  A DISK        12-NOV-19       1       1       NO         TAG20191112T194801


RMAN> list backupset 44;


List of Backup Sets
===================


BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ ---------------
44      Full    10.47M     DISK        00:00:00     12-NOV-19      
        BP Key: 44   Status: AVAILABLE  Compressed: NO  Tag: TAG20191112T194801
        Piece Name: /u01/app/oracle/fast_recovery_area/testdb/TESTDB/autobackup/2019_11_12/o1_mf_s_1024170481_gwow2k8b_.bkp
  Control File Included: Ckp SCN: 1458081      Ckp time: 12-NOV-19
  SPFILE Included: Modification time: 12-NOV-19
  SPFILE db_unique_name: TESTDB
