--RMAN ARCHIVELOG MANANGEMENT

SQL> alter system switch logfile;

System altered.

SQL> alter system switch logfile;

System altered.

SQL> alter system switch logfile;

System altered.

SQL> alter system switch logfile;

System altered.



 rman target=/

Recovery Manager: Release 12.2.0.1.0 - Production on Tue Nov 12 18:58:54 2019

Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.

connected to target database: TESTDB (DBID=2807463263)

RMAN> backup archivelog all;

RMAN> list backup of archivelog all;


List of Backup Sets
===================


BS Key  Size       Device Type Elapsed Time Completion Time
------- ---------- ----------- ------------ ---------------
17      199.00K    DISK        00:00:00     12-NOV-19      
        BP Key: 17   Status: AVAILABLE  Compressed: NO  Tag: TAG20191112T185907
        Piece Name: /u01/app/oracle/fast_recovery_area/testdb/TESTDB/backupset/2019_11_12/o1_mf_annnn_TAG20191112T185907_gwos6vvw_.bkp

  List of Archived Logs in backup set 17
  Thrd Seq     Low SCN    Low Time  Next SCN   Next Time
  ---- ------- ---------- --------- ---------- ---------
  1    12      1454648    12-NOV-19 1454670    12-NOV-19
  1    13      1454670    12-NOV-19 1454739    12-NOV-19
  1    14      1454739    12-NOV-19 1454753    12-NOV-19
  1    15      1454753    12-NOV-19 1454838    12-NOV-19
  1    16      1454838    12-NOV-19 1454852    12-NOV-19
  1    17      1454852    12-NOV-19 1455810    12-NOV-19
  1    18      1455810    12-NOV-19 1455814    12-NOV-19
  1    19      1455814    12-NOV-19 1455817    12-NOV-19
  1    20      1455817    12-NOV-19 1455820    12-NOV-19
  1    21      1455820    12-NOV-19 1455849    12-NOV-19


RMAN> delete noprompt backup of archivelog all;

using channel ORA_DISK_1

List of Backup Pieces
BP Key  BS Key  Pc# Cp# Status      Device Type Piece Name
------- ------- --- --- ----------- ----------- ----------
17      17      1   1   AVAILABLE   DISK        /u01/app/oracle/fast_recovery_area/testdb/TESTDB/backupset/2019_11_12/o1_mf_annnn_TAG20191112T185907_gwos6vvw_.bkp
deleted backup piece
backup piece handle=/u01/app/oracle/fast_recovery_area/testdb/TESTDB/backupset/2019_11_12/o1_mf_annnn_TAG20191112T185907_gwos6vvw_.bkp RECID=17 STAMP=1024167547
Deleted 1 objects


--rman has no backup 
RMAN> list backup of archivelog all;

specification does not match any backup in the repository

RMAN> backup archivelog all;



--Rman deletes archivelog backups at least 1 time backedup
RMAN> delete archivelog like '%' backed up 1 times to device type disk;

released channel: ORA_DISK_1
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=140 device type=DISK
List of Archived Log Copies for database with db_unique_name TESTDB
=====================================================================

Key     Thrd Seq     S Low Time 
------- ---- ------- - ---------
12      1    12      A 12-NOV-19
        Name: /u01/app/oracle/fast_recovery_area/testdb/TESTDB/archivelog/2019_11_12/o1_mf_1_12_gwoq80od_.arc

13      1    13      A 12-NOV-19
        Name: /u01/app/oracle/fast_recovery_area/testdb/TESTDB/archivelog/2019_11_12/o1_mf_1_13_gwoqcdb3_.arc



--delete archivelog older than sysdate-1
RMAN> delete archivelog until time 'sysdate-1'

--creates archivelog
SQL> alter system switch logfile;

System altered.

RMAN> backup archivelog all delete all input;
