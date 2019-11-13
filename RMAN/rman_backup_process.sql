--RMAN BACKUP PROCESS

--Cconnect to database
:~]# rman target=/

Recovery Manager: Release 12.2.0.1.0 - Production on Tue Nov 12 18:17:17 2019

Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.

connected to target database: TESTDB (DBID=2807463263)

--start database backup
RMAN> backup database plus archivelog;


RMAN> backup incremental level 0 database tag 'inc_level0' plus archivelog;

RMAN> backup incremental level 1 database tag 'inc_level1' plus archivelog;

RMAN> backup incremental level 1 cumulative database tag 'inc_level1' plus archivelog;



--DISPLAY Backups
RMAN> list backup of database;


List of Backup Sets
===================


BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ ---------------
2       Full    1.26G      DISK        00:00:23     12-NOV-19      
        BP Key: 2   Status: AVAILABLE  Compressed: NO  Tag: TAG20191112T181756
        Piece Name: /u01/app/oracle/fast_recovery_area/testdb/TESTDB/backupset/2019_11_12/o1_mf_nnndf_TAG20191112T181756_gwopsnmd_.bkp
  List of Datafiles in backup set 2
  File LV Type Ckp SCN    Ckp Time  Abs Fuz SCN Sparse Name
  ---- -- ---- ---------- --------- ----------- ------ ----
  1       Full 1454365    12-NOV-19              NO    /u01/app/oracle/oradata/TESTDB/datafile/o1_mf_system_gwnsh452_.dbf
  3       Full 1454365    12-NOV-19              NO    /u01/app/oracle/oradata/TESTDB/datafile/o1_mf_sysaux_gwnsj7dx_.dbf
  4       Full 1454365    12-NOV-19              NO    /u01/app/oracle/oradata/TESTDB/datafile/o1_mf_undotbs1_gwnsk0h7_.dbf
  7       Full 1454365    12-NOV-19              NO    /u01/app/oracle/oradata/TESTDB/datafile/o1_mf_users_gwnsk1kb_.dbf




--OBSOLETE BACKUPS

--Backups we do not need time passed;

--Rman only keep one backup file
RMAN> configure retention policy to redundancy 1;

old RMAN configuration parameters:
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;
new RMAN configuration parameters:
CONFIGURE RETENTION POLICY TO REDUNDANCY 1;
new RMAN configuration parameters are successfully store


--displays backups that not need to keep that given retention policy redybdancy
RMAN> report obsolete;

--usefull 
RMAN> delete obsolete;

--this command allows you run 'delete obsolete' which taken 1 week ago
RMAN> configure retention policy to recovery window of 7 days;


/*

EXPIRED BACKUPS

--Back sets or pieces are not found in a directory which given in rman directory

--delete one of backup
rm -f /u01/app/oracle/fast_recovery_area/testdb/TESTDB/autobackup/2019_11_12/o1_mf_s_1024165814_gwoqjp7j_.bkp

*/
RMAN> crosscheck backup;
RMAN> list expired backup;
List of Backup Sets
===================


BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ ---------------
16      Full    10.19M     DISK        00:00:00     12-NOV-19      
        BP Key: 16   Status: EXPIRED  Compressed: NO  Tag: TAG20191112T183014
        Piece Name: /u01/app/oracle/fast_recovery_area/testdb/TESTDB/autobackup/2019_11_12/o1_mf_s_1024165814_gwoqjp7j_.bkp
  SPFILE Included: Modification time: 12-NOV-19
  SPFILE db_unique_name: TESTDB
  Control File Included: Ckp SCN: 1454861      Ckp time: 12-NOV-19

--delete expired backup
RMAN> delete expired backup;

using channel ORA_DISK_1

List of Backup Pieces
BP Key  BS Key  Pc# Cp# Status      Device Type Piece Name
------- ------- --- --- ----------- ----------- ----------
16      16      1   1   EXPIRED     DISK        /u01/app/oracle/fast_recovery_area/testdb/TESTDB/autobackup/2019_11_12/o1_mf_s_1024165814_gwoqjp7j_.bkp

Do you really want to delete the above objects (enter YES or NO)? yes
deleted backup piece
backup piece handle=/u01/app/oracle/fast_recovery_area/testdb/TESTDB/autobackup/2019_11_12/o1_mf_s_1024165814_gwoqjp7j_.bkp RECID=16 STAMP=1024165814
Deleted 1 EXPIRED objects


--delete backupset with backup BS Key
RMAN> delete noprompt backupset 6; 
