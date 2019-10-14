 --Login to GGSCI

GGSCI (hostname) 1> dblogin UserIdAlias OGGADMIN
--Successfully logged into database.

GGSCI (hostname) 2>

2. Add trandata for new table

GGSCI (hostname) 2> dblogin userid ogg, password n88E84XRsN

GGSCI (hostname) 2> add trandata XXX.XX_TABLE

Logging of supplemental redo data enabled for table XXX.XX_TABLE
TRANDATA for scheduling columns has been added on table 'XXX.XX_TABLE'.


GGSCI (hostname) 9> add trandata XXX.XX_TABLE2


2019-10-14 11:43:40  WARNING OGG-00706  Failed to add supplemental log group on table XXX.XX_TABLE2 due to 
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired SQL 
ALTER TABLE XXX.XX_TABLE2 ADD SUPPLEMENTAL LOG GROUP "GGS_248266" ("SEQ") ALWAYS  /* GOLDENGATE_DDL_REPLICATION */.

2019-10-14 11:43:40  WARNING OGG-00706  Failed to add supplemental log group on table XXX.XX_TABLE2 due to 
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired SQL ALTER TABLE XXX.XX_TABLE2 
ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY, UNIQUE, FOREIGN KEY) COLUMNS  /* GOLDENGATE_DDL_REPLICATION */.


GGSCI (hostname) 9> exit

sqlplus/ as sysdba

SQL > alter table XXX.XX_TABLE2 ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

SQL > exit

#ggsci

GGSCI (hostname) > add trandata XXX.XX_TABLE2

Logging of supplemental redo data enabled for table XXX.XX_TABLE2
TRANDATA for scheduling columns has been added on table 'XXX.XX_TABLE2'.



3. Add table to Extract

GGSCI (hostname) 4> edit params eraj

-- Add below
TABLE XXX.XX_TABLE2;
TABLE XXX.XX_TABLE;

GGSCI (hostname) 5> view params eraj

Extract ERAJ
SETENV (ORACLE_SID='TEST')
UserIdAlias OGGADMIN
TranlogOptions IntegratedParams (max_sga_size 256)
Exttrail ./dirdat/ea
LOGALLSUPCOLS
UPDATERECORDFORMAT COMPACT
TABLE SOURCE.EMP;
TABLE SOURCE.EMPLOYEE;
TABLE SOURCE.X;
TABLE SOURCE.X1;

TABLE XXX.XX_TABLE2;
TABLE XXX.XX_TABLE;

GGSCI (hostname) 6>

4. Add table to Pump

GGSCI (hostname) 7> edit params praj

-- Add below
TABLE XXX.XX_TABLE2;
TABLE XXX.XX_TABLE;


GGSCI (hostname) 8> view params praj

Extract  PRAJ
SETENV (ORACLE_SID='TEST')
UserIdAlias OGGADMIN
rmthost rac2, mgrport 7809
rmttrail ./dirdat/pa
TABLE SOURCE.EMP;
TABLE SOURCE.EMPLOYEE;
TABLE SOURCE.X;
TABLE SOURCE.X1;


TABLE XXX.XX_TABLE2;
TABLE XXX.XX_TABLE;


GGSCI (hostname) 9>

5. Restart Extract

GGSCI (hostname) 11> stop eraj

Sending STOP request to EXTRACT ERAJ ...
Request processed.


GGSCI (hostname) 12> start eraj

Sending START request to MANAGER ...
EXTRACT ERAJ starting


GGSCI (hostname) 13>

6. Restart Pump

GGSCI (hostname) 13> stop praj

Sending STOP request to EXTRACT PRAJ ...
Request processed.


GGSCI (hostname) 14> start praj

Sending START request to MANAGER ...
EXTRACT PRAJ starting


GGSCI (hostname) 15>

7. Verify Status

GGSCI (hostname) 15> info all



GGSCI (hostname) 16>

8. Capture current SCN

SQL> select current_scn from v$database;

CURRENT_SCN
-----------
    2298283 <----

SQL>

9. Export Table using FLASHBACK_SCN

SQL> select * from dba_directories where DIRECTORY_NAME='DATA_PUMP_DIR';

OWNER      DIRECTORY_NAME            DIRECTORY_PATH                           ORIGIN_CON_ID
---------- ------------------------- ---------------------------------------- -------------
SYS        DATA_PUMP_DIR             /u01/app/oracle/admin/PSG01DAS/dpdump/               0

SQL>


[oracle@rac1 ~]$ expdp \'/ as sysdba\' directory=data_pump_dir dumpfile=initload.dmp logfile=initload.log tables=XXX.XX_TABLE2,XXX.XX_TABLE flashback_scn=2298283

Export: Release 12.2.0.1.0 - Production on Wed Apr 24 00:52:11 2019

Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.

Connected to: Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production
FLASHBACK automatically enabled to preserve database integrity.
Starting "SYS"."SYS_EXPORT_TABLE_01":  "/******** AS SYSDBA" directory=data_pump_dir dumpfile=initload.dmp logfile=initload.log tables=XXX.XX_TABLE2,XXX.XX_TABLE flashback_scn=2298283
Processing object type TABLE_EXPORT/TABLE/TABLE_DATA
Processing object type TABLE_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS
Processing object type TABLE_EXPORT/TABLE/STATISTICS/MARKER
Processing object type TABLE_EXPORT/TABLE/PROCACT_INSTANCE
Processing object type TABLE_EXPORT/TABLE/TABLE
Processing object type TABLE_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
. . exported "SOURCE"."DASANI"                           5.687 KB      15 rows
Master table "SYS"."SYS_EXPORT_TABLE_01" successfully loaded/unloaded
******************************************************************************
Dump file set for SYS.SYS_EXPORT_TABLE_01 is:
  /u01/app/oracle/admin/PSG01DAS/dpdump/initload.dmp
Job "SYS"."SYS_EXPORT_TABLE_01" successfully completed at Wed Apr 24 00:52:48 2019 elapsed 0 00:00:28

[oracle@rac1 ~]$

10. Transfer dump to target server

[oracle@rac1 ~]$ scp /u01/app/oracle/admin/PSG01DAS/dpdump/initload.dmp oracle@rac2:/u01/app/oracle/admin/USG01DAS/dpdump/
oracle@rac2's password:
initload.dmp                 100%  200KB 200.0KB/s   00:00
[oracle@rac1 ~]$
Target:


11. Import new table

SQL> col OWNER for a10
SQL> col DIRECTORY_NAME for a25
SQL> col DIRECTORY_PATH for a40
SQL> set lines 180
SQL> select * from dba_directories where DIRECTORY_NAME='DATA_PUMP_DIR';

OWNER      DIRECTORY_NAME            DIRECTORY_PATH                           ORIGIN_CON_ID
---------- ------------------------- ---------------------------------------- -------------
SYS        DATA_PUMP_DIR             /u01/app/oracle/admin/USG01DAS/dpdump/               0

SQL>

[oracle@rac2 ~]$ impdp \'/ as sysdba\' directory=data_pump_dir dumpfile=initload.dmp logfile=initload_imp.log remap_schema=source:target transform=segment_attributes:n transform=oid:n

Import: Release 12.2.0.1.0 - Production on Wed Apr 24 00:58:28 2019

Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.

Connected to: Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production
Master table "SYS"."SYS_IMPORT_FULL_01" successfully loaded/unloaded
Starting "SYS"."SYS_IMPORT_FULL_01":  "/******** AS SYSDBA" directory=data_pump_dir dumpfile=initload.dmp logfile=initload_imp.log remap_schema=source:target transform=segment_attributes:n transform=oid:n
Processing object type TABLE_EXPORT/TABLE/PROCACT_INSTANCE
Processing object type TABLE_EXPORT/TABLE/TABLE
Processing object type TABLE_EXPORT/TABLE/TABLE_DATA
. . imported "TARGET"."DASANI"                           5.687 KB      15 rows
Processing object type TABLE_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
Processing object type TABLE_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS
Processing object type TABLE_EXPORT/TABLE/STATISTICS/MARKER
Job "SYS"."SYS_IMPORT_FULL_01" successfully completed at Wed Apr 24 00:58:54 2019 elapsed 0 00:00:23

[oracle@rac2 ~]$

12. Add table to Replicat

Note : 

Please use single quotes since OGG v12 uses ANSI SQL parameter by default, if you use double quotes then you may receive this error.
You can use double quotes in pre OGG v12
    

2019-04-24T01:10:34.244+0800  ERROR   OGG-00375  Oracle GoldenGate Delivery for Oracle, rraj.prm:  Error in FILTER clause.
2019-04-24T01:10:39.386+0800  ERROR   OGG-01668  Oracle GoldenGate Delivery for Oracle, rraj.prm:  PROCESS ABENDING.

GGSCI (targethostname) 14> edit params rraj

-- Add below line

Map XXX.XX_TABLE2,XXX.XX_TABLE, target TARGET.DASANI, FILTER ( @GETENV('TRANSACTION', 'CSN') > 2298283);


GGSCI (targethostname) 15> view params rraj

Replicat RRAJ
SETENV(ORACLE_SID='USG01DAS')
UserIdAlias OGGADMIN
DBOPTIONS INTEGRATEDPARAMS(parallelism 6)
AssumeTargetDefs
DiscardFile ./dirrpt/rpdw.dsc, Purge
UserIdAlias OGGADMIN
Map SOURCE.EMP, target TARGET.EMP;
Map SOURCE.EMPLOYEE, target TARGET.EMPLOYEE;
Map SOURCE.X, target TARGET.X;
Map SOURCE.X1, target TARGET.X1;
Map XXX.XX_TABLE2,XXX.XX_TABLE, target TARGET.DASANI, FILTER ( @GETENV('TRANSACTION', 'CSN') > 2298283);  <-----


GGSCI (targethostname) 16>

13. Restart Replicat

GGSCI (targethostname) 16> stop rraj

Sending STOP request to REPLICAT RRAJ ...
Request processed.


GGSCI (targethostname) 17>
GGSCI (targethostname) 19> start rraj

Sending START request to MANAGER ...
REPLICAT RRAJ starting


GGSCI (targethostname) 20>

14. Verify Status

GGSCI (targethostname) 20> info all

Program     Status      Group       Lag at Chkpt  Time Since Chkpt

MANAGER     RUNNING
REPLICAT    RUNNING     RRAJ        00:00:00      00:00:11


GGSCI (targethostname) 21>

15. Data sync verify

Source:

SQL> SELECT COUNT(*) FROM XXX.XX_TABLE2,XXX.XX_TABLE;

  COUNT(*)
----------
        15 <---

SQL> 
SQL> INSERT INTO XXX.XX_TABLE2,XXX.XX_TABLE VALUES ('CHITTI','MANAGER');

1 row created.

SQL> INSERT INTO XXX.XX_TABLE2,XXX.XX_TABLE VALUES ('SRINIVAS','LEAD');

1 row created.

SQL> commit;

Commit complete.

SQL> SELECT COUNT(*) FROM XXX.XX_TABLE2,XXX.XX_TABLE;

  COUNT(*)
----------
        17 <-----

SQL>
Target:

SQL> SELECT COUNT(*) FROM TARGET.DASANI;

  COUNT(*)
----------
        15

SQL>

SQL> SELECT COUNT(*) FROM TARGET.DASANI;

  COUNT(*)
----------
        17 <----

SQL>

It's sync now, next step we need to FILTER PARAMETER from Relicat

16. Remove the FILTER parameters replicat

GGSCI (targethostname) 31> dblogin UserIdAlias OGGADMIN
Successfully logged into database.

GGSCI (targethostname as OGGADMIN@USG01DAS) 32> lag rraj

Sending GETLAG request to REPLICAT RRAJ ...
Last record lag 246 seconds.
Low watermark lag: 1.
High watermark lag: 258.
Low watermark position: 2211928.
High watermark position: 2316576.
At EOF, no more records to process


GGSCI (targethostname as OGGADMIN@USG01DAS) 33> edit params rraj

-- From 
Map XXX.XX_TABLE2,XXX.XX_TABLE, target TARGET.DASANI, FILTER ( @GETENV('TRANSACTION', 'CSN') > 2298283);

-- To
Map XXX.XX_TABLE2,XXX.XX_TABLE, target TARGET.DASANI;


GGSCI (targethostname as OGGADMIN@USG01DAS) 34> view params rraj

Replicat RRAJ
SETENV(ORACLE_SID='USG01DAS')
UserIdAlias OGGADMIN
DBOPTIONS INTEGRATEDPARAMS(parallelism 6)
AssumeTargetDefs
DiscardFile ./dirrpt/rpdw.dsc, Purge
UserIdAlias OGGADMIN
Map SOURCE.EMP, target TARGET.EMP;
Map SOURCE.EMPLOYEE, target TARGET.EMPLOYEE;
Map SOURCE.X, target TARGET.X;
Map SOURCE.X1, target TARGET.X1;
Map XXX.XX_TABLE2,XXX.XX_TABLE, target TARGET.DASANI; <-----


GGSCI (targethostname as OGGADMIN@USG01DAS) 35>

17. Restart the replicat

GGSCI (targethostname as OGGADMIN@USG01DAS) 35> stop rraj

Sending STOP request to REPLICAT RRAJ ...
Request processed.


GGSCI (targethostname as OGGADMIN@USG01DAS) 36> 

GGSCI (targethostname as OGGADMIN@USG01DAS) 37> start rraj

Sending START request to MANAGER ...
REPLICAT RRAJ starting


GGSCI (targethostname as OGGADMIN@USG01DAS) 38>

18. Verify Status

GGSCI (targethostname as OGGADMIN@USG01DAS) 38> info all

Program     Status      Group       Lag at Chkpt  Time Since Chkpt

MANAGER     RUNNING
REPLICAT    RUNNING     RRAJ        00:00:00      00:00:05


GGSCI (targethostname as OGGADMIN@USG01DAS) 39>

19. Re-verify data sync

Source:

SQL> SELECT COUNT(*) FROM XXX.XX_TABLE2,XXX.XX_TABLE;

  COUNT(*)
----------
        17 <----

SQL>    INSERT INTO XXX.XX_TABLE2,XXX.XX_TABLE VALUES ('SOMU','DBA');

1 row created.

SQL> INSERT INTO XXX.XX_TABLE2,XXX.XX_TABLE VALUES ('ZABI','DBA');

1 row created.

SQL> INSERT INTO XXX.XX_TABLE2,XXX.XX_TABLE VALUES ('GIRI','BIGDATA');

1 row created.

SQL> COMMIT;
