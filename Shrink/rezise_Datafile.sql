Oracle Database - Enterprise Edition - Version 9.2.0.1 and later
Oracle Database - Standard Edition - Version 11.2.0.4 to 11.2.0.4 [Release 11.2]
Oracle Database - Standard Edition - Version 11.1.0.7 to 11.1.0.7 [Release 11.1]
Oracle Database Cloud Schema Service - Version N/A and later
Oracle Database Exadata Express Cloud Service - Version N/A and later
Information in this document applies to any platform.
Checked for relevance on 17 April 2012



PURPOSE
NOTE: In the images and/or the document content below, the user information and environment data used represents fictitious data from the Oracle sample or bulit-in schema(s), Public Documentation delivered with an Oracle database product or other training material.  Any similarity to actual environments, actual persons, living or dead, is purely coincidental and not intended in any manner.
This note will discuss resizing of Oracle datafiles (larger or smaller), provide different test case and scripts for different scenarios.

SCOPE
The intended audience for this document is for experienced DBA's 

DETAILS
Oracle file sizing is vital part of managing Oracle databases

In older versions (Oracle 7.1 and lower) the only methods available to resize tablespace storage were

    * Drop and recreate the tablespace with different sized datafiles (decrease / shrink)
    * Add one or more datafiles to the tablespace (increase)

Beginning in Oracle 7.2 Oracle introduced the ALTER DATABASE DATAFILE .... RESIZE command.

This option allows you to change the physical size of a datafile from what was specified during its creation.

Attempting to use the RESIZE command on versions prior to 7.2 will receive the following error:

ORA-00923: FROM keyword not found where expected
 

=============================
1. Increase Datafile Size
=============================
To increase the size of a datafile, you would use the command:

ALTER DATABASE DATAFILE '<full path and name of the file>' RESIZE [K|M|G];

where the size specified is larger than the existing file size.

The current size of a datafile may be found by querying V$DATAFILE.BYTES or DBA_DATA_FILES.BYTES

Examples:

column file_name format a45

select file_name, bytes from dba_data_files where file_name like '%test%';

FILE_NAME                                     BYTES
--------------------------------------------- ----------
/u01/app/oracle/oradata/v10205/test.dbf          1048576


ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/v10205/test.dbf' RESIZE 10567680;

    In this example the size before resize was 1048576 bytes and after the resize 10567680 bytes

SELECT FILE#, STATUS, ENABLED, CHECKPOINT_CHANGE#, BYTES, CREATE_BYTES, NAME FROM V$DATAFILE;

FILE#  STATUS  ENABLED    CHECKPOINT BYTES      CREATE_BYT NAME
------ ------- ---------- ---------- ---------- ---------- ----------------
5      ONLINE  READ WRITE 7450       2097152    102400     /databases/oracle/test.dbf

   In this example the file was created with a size of 100K (CREATE_BYTES) and is currently 2 MB in size ... this shows that the file was resized.

=============================
2. Decrease Datafile Size
=============================
To decrease the size of a datafile, you would use the command:

ALTER DATABASE DATAFILE '<full path and name of the file>' RESIZE [K|M|G];

where the size specified is smaller than the existing file size.

The current size of a datafile may be found by querying V$DATAFILE.BYTES or DBA_DATA_FILES.BYTES (see section 1 for examples)

Reducing the size of a datafile is more complicated than increasing the size of a datafile as space cannot be deallocated from a datafile that is currently being used by database objects.

To remove space from a datafile, you have to have contiguous free space at the END of the datafile. 

The view DBA_FREE_SPACE is used to display the free space (space not being used) in a datafile.

For example:

SELECT * FROM DBA_FREE_SPACE
WHERE TABLESPACE_NAME='TEST'
ORDER BY BLOCK_ID;

TABLESPACE_NAME    FILE_ID    BLOCK_ID   BYTES      BLOCKS
------------------ ---------- ---------- ---------- ----------
TEST                        5          2     102400         50
TEST                        5         55      96256         47
TEST                        5        102    1890304        923

There are two large extents at the high end of the datafile

BLOCK_ID=55 contains 47 blocks
BLOCK_ID=102 contains 923 blocks
This means there are 1986560 unused bytes at the end of our datafile, almost 2 MB.

We want to leave some room for growth in our datafile, and depending on how the objects in that datafile allocate new extents, we could remove up to 1.89 MB of disk space from the datafile without damaging any objects in the tablespace.

If you have a large extent in the middle of a datafile, and some object taking up room at the end of the datafile, you can use the query FINDEXT.SQL below to find this object. If you export this object, then drop it, you should then free up contiguous space at the end of your datafile so you will be able to resize it smaller.

Make sure you leave enough room in the datafile for importing the object back into the tablespace.

=============================
3. Cautions and Warnings and Notes
=============================
A) For safety reasons, you should take a backup of your database whenever you change its structure, which includes altering the size of datafiles.

B) If you try to resize a datafile to a size smaller than is needed to contain all the database objects in that datafile, the following error is returned:

ORA-03297: file contains blocks of data beyond requested RESIZE value

Or

ORA-03297: file contains used data beyond requested RESIZE value

The resize operation will fail at this point.

C) If you try to resize a datafile larger than can be created, you will also get an error.

For instance, if trying to create a file of 2 GB, without having 2 GB of available disk space the following errors will be returned:

ORA-01237: cannot extend datafile
ORA-01110: data file : ''
ORA-19502: write error on file "", blockno (blocksize=)
ORA-27072: File I/O error

If you check V$DATAFILE, you will see that the file size does not change unless the operation is successful.

D) MANUAL versus AUTOMATIC extension:

Be careful giving datafiles the AUTOEXTEND attribute, and make sure to specify the NEXT and MAXSIZE parameters.

If using dictionary managed tablespaces (DMT)

set appropriate values for the default storage parameters on tablespace level and the MAXEXTENTS parameter
avoid UNLIMITED sizes and extents to prevent objects with a very high number of extents to be created which causes not only a huge number of records in the dictionary tables, but dropping them can tade long time with SMON consuming a lot of CPU resources
If using multiple database writers (db_writers > 1) in RDBMS versions below version 7.3.4.1, might be encounterd. This appears as ORA-7374 errors when accessing the datafile after it has been resized.  The workaround is to shutdown and restart the database after resizing a datafile (a convenient time to take a backup). This will cause the new datafile size information to be refreshed to all the DBWR slave processes.

E) Please be aware that beside the command 'ALTER DATABASE DATAFILE ... RESIZE ... ' there are still alternatives like the export and import utility (including DataPump) to perform a resize of a datafile. Using export/import will lead also result in a reorganization of the objects in the tablespace related to the datafile.

=============================
4. SCRIPTS
=============================
FINDEXT.SQL 

-- FINDEXT.SQL

-- This script lists all the extents contained in that datafile,
-- the block_id where the extent starts,
-- and how many blocks the extent contains.
-- It also shows the owner, segment name, and segment type.

-- Input: FILE_ID from DBA_DATA_FILES or FILE# from V$DATAFILE

SET ECHO OFF
SET PAGESIZ 25

column file_name format a50
select file_name, file_id from dba_data_files order by 2;

ttitle -
center 'Segment Extent Summary' skip 2

col ownr format a8 heading 'Owner' justify c
col type format a8 heading 'Type' justify c trunc
col name format a30 heading 'Segment Name' justify c
col exid format 990 heading 'Extent#' justify c
col fiid format 9990 heading 'File#' justify c
col blid format 99990 heading 'Block#' justify c
col blks format 999,990 heading 'Blocks' justify c

select owner ownr, segment_name name, segment_type type, extent_id exid, file_id fiid, block_id blid, blocks blks
from dba_extents
where file_id = &file_id
order by block_id
/

Sample Output:

SQL> @findext.sql

FILE_NAME FILE_ID
-------------------------------------------------- ----------
/u01/app/oracle/oradata/v10205/system01.dbf 1
/u01/app/oracle/oradata/v10205/undotbs01.dbf 2
/u01/app/oracle/oradata/v10205/sysaux01.dbf 3
/u01/app/oracle/oradata/v10205/users01.dbf 4

Enter value for file_id: 4
old 3: where file_id = &file_id
new 3: where file_id = 4

Segment Extent Summary

Owner    Segment Name                   Type     Extent# File# Block# Blocks
-------- ------------------------------ -------- ------- ----- ------ --------
USER     EMP                            TABLE          0     4      2        5
USER     TAB3                           TABLE          0     4    108        5
USER     TEST                           TABLE          0     4    348        5
USER     PK_EMP                         INDEX          0     4    483        5
USER     EMP                            TABLE          1     4    433        5
USER     EMP                            TABLE          2     4    438       10
USER     PK_EMP                         INDEX          1     4    488       10


SHRINK_DATAFILE.SQL

-- SHRINK_DATAFILE.SQL

-- This script lists the object names and types that must be moved in order to resize a datafile to a specified smaller size

-- Input: FILE_ID from DBA_DATA_FILES or FILE# from V$DATAFILE
-- Size in bytes that the datafile will be resized to

SET SERVEROUTPUT ON

DECLARE
     V_FILE_ID NUMBER;
     V_BLOCK_SIZE NUMBER;
     V_RESIZE_SIZE NUMBER;
BEGIN
     V_FILE_ID := &FILE_ID;
     V_RESIZE_SIZE := &RESIZE_FILE_TO;

     SELECT BLOCK_SIZE INTO V_BLOCK_SIZE FROM V$DATAFILE WHERE FILE# = V_FILE_ID;

     DBMS_OUTPUT.PUT_LINE('.');
     DBMS_OUTPUT.PUT_LINE('.');
     DBMS_OUTPUT.PUT_LINE('.');
     DBMS_OUTPUT.PUT_LINE('OBJECTS IN FILE '||V_FILE_ID||' THAT MUST MOVE IN ORDER TO RESIZE THE FILE TO '||V_RESIZE_SIZE||' BYTES');
     DBMS_OUTPUT.PUT_LINE('===================================================================');
     DBMS_OUTPUT.PUT_LINE('NON-PARTITIONED OBJECTS');
     DBMS_OUTPUT.PUT_LINE('===================================================================');

     for my_record in (
          SELECT DISTINCT(OWNER||'.'||SEGMENT_NAME||' - OBJECT TYPE = '||SEGMENT_TYPE) ONAME
          FROM DBA_EXTENTS
          WHERE (block_id + blocks-1)*V_BLOCK_SIZE > V_RESIZE_SIZE 
          AND FILE_ID = V_FILE_ID
          AND SEGMENT_TYPE NOT LIKE '%PARTITION%'
          ORDER BY 1) LOOP
               DBMS_OUTPUT.PUT_LINE(my_record.ONAME); 
     END LOOP;

     DBMS_OUTPUT.PUT_LINE('===================================================================');
     DBMS_OUTPUT.PUT_LINE('PARTITIONED OBJECTS');
     DBMS_OUTPUT.PUT_LINE('===================================================================');

     for my_record in (
          SELECT DISTINCT(OWNER||'.'||SEGMENT_NAME||' - PARTITION = '||PARTITION_NAME||' - OBJECT TYPE = '||SEGMENT_TYPE) ONAME
          FROM DBA_EXTENTS
          WHERE (block_id + blocks-1)*V_BLOCK_SIZE > V_RESIZE_SIZE
          AND FILE_ID = V_FILE_ID 
          AND SEGMENT_TYPE LIKE '%PARTITION%'
          ORDER BY 1) LOOP 
               DBMS_OUTPUT.PUT_LINE(my_record.ONAME);
     END LOOP;

END;
/

Sample Output:

SQL > @SHRINK_DATAFILE.SQL

Enter value for file_id: 2
old 6: V_FILE_ID := &FILE_ID;
new 6: V_FILE_ID := 2;
Enter value for resize_file_to: 300000000
old 7: V_RESIZE_SIZE := &RESIZE_FILE_TO;
new 7: V_RESIZE_SIZE := 300000000;
.
.
.
OBJECTS IN FILE 2 THAT MUST MOVE IN ORDER TO RESIZE THE FILE TO 300000000 BYTES
===================================================================
NON-PARTITIONED OBJECTS
===================================================================
SYS.I_WRI$_OPTSTAT_HH_OBJ_ICOL_ST - OBJECT TYPE = INDEX
...

===================================================================
PARTITIONED OBJECTS
===================================================================
SYS.WRH$_ACTIVE_SESSION_HISTORY - PARTITION = WRH$_ACTIVE_512113771_430 - OBJECT TYPE = TABLE PARTITION
...
 

=============================
5. CASE STUDY
=============================
A. Approach 1
sqlplus / as sysdba

-- Setup for the testcase

alter system set recyclebin=on;

create tablespace test datafile '/u01/app/oracle/oradata/v10205/test.dbf' size 100m extent management local uniform size 1m;

select bytes from v$datafile where file# = 5;

BYTES
----------
104857600


!ls -alt /u01/app/oracle/oradata/v10205/test.dbf

-rw-r----- 1 oracle dba 104865792 Apr 20 07:49 /u01/app/oracle/oradata/v10205/test.dbf

create user test identified by test;
grant dba to test;
alter user test default tablespace test;
connect test/test;

-- Fill up the TEST Tablespace

BEGIN
   for i in 1..19 LOOP
      execute immediate 'create table ' || 'TEST'||i ||' as select * from dba_objects';
   end loop;
end;
/

select bytes-ebytes from (select sum(bytes) ebytes from dba_extents where file_id=5), dba_data_files where file_id=5;

BYTES-EBYTES
------------
5242880

select sum(bytes) from dba_free_space where file_id=5;

SUM(BYTES)
----------
4194304
-- Examine the extent storage for the TEST datafile with FINDEXT.SQL

@FINDEXT

 

                     Segment Extent Summary

FILE_NAME                                             FILE_ID
-------------------------------------------------- ----------
/u01/app/oracle/oradata/v10205/system01.dbf                 1
/u01/app/oracle/oradata/v10205/undotbs01.dbf                2
/u01/app/oracle/oradata/v10205/sysaux01.dbf                 3
/u01/app/oracle/oradata/v10205/users01.dbf                  4
/u01/app/oracle/oradata/v10205/test.dbf                     5

Enter value for file_id: 5
old   3: where file_id = &file_id
new   3: where file_id = 5

                          Segment Extent Summary

Owner            Segment Name            Type   Extent# File# Block#  Blocks
-------- ------------------------------ -------- ------- ----- ------ --------
TEST     TEST1                          TABLE          0     5      9      128
TEST     TEST1                          TABLE          1     5    137      128
TEST     TEST1                          TABLE          2     5    265      128
TEST     TEST1                          TABLE          3     5    393      128
TEST     TEST1                          TABLE          4     5    521      128
TEST     TEST2                          TABLE          0     5    649      128
...
TEST     TEST18                         TABLE          3     5  11273      128
TEST     TEST18                         TABLE          4     5  11401      128
TEST     TEST19                         TABLE          0     5  11529      128
TEST     TEST19                         TABLE          1     5  11657      128
TEST     TEST19                         TABLE          2     5  11785      128
TEST     TEST19                         TABLE          3     5  11913      128
TEST     TEST19                         TABLE          4     5  12041      128


-- DROP TABLES TEST2 TO TEST17 AND TEST19

BEGIN
   for i in 2..17 LOOP
      execute immediate 'DROP table ' || 'TEST'||i;
   end loop;
   execute immediate 'DROP TABLE TEST19';
end;
/

-- Examine the storage for the TEST datafile with FINDEXT.SQL

@FINDEXT

                              Segment Extent Summary

FILE_NAME                                             FILE_ID
-------------------------------------------------- ----------
/u01/app/oracle/oradata/v10205/system01.dbf                 1
/u01/app/oracle/oradata/v10205/undotbs01.dbf                2
/u01/app/oracle/oradata/v10205/sysaux01.dbf                 3
/u01/app/oracle/oradata/v10205/users01.dbf                  4
/u01/app/oracle/oradata/v10205/test.dbf                     5

Enter value for file_id: 5
old   3: where file_id = &file_id
new   3: where file_id = 5

                          Segment Extent Summary

Owner            Segment Name            Type   Extent# File# Block#  Blocks
-------- ------------------------------ -------- ------- ----- ------ --------
TEST     TEST1                          TABLE          0     5      9      128
TEST     TEST1                          TABLE          1     5    137      128
TEST     TEST1                          TABLE          2     5    265      128
TEST     TEST1                          TABLE          3     5    393      128
TEST     TEST1                          TABLE          4     5    521      128
TEST     TEST18                         TABLE          0     5  10889      128
TEST     TEST18                         TABLE          1     5  11017      128
TEST     TEST18                         TABLE          2     5  11145      128
TEST     TEST18                         TABLE          3     5  11273      128
TEST     TEST18                         TABLE          4     5  11401      128



-- NOTE THAT THERE IS NOW A LARGE HOLE IN THE MIDDLE OF THE TEST TABLESPACE DATAFILE

-- Examine the Recylebin Contents for the Test Tablespace

SELECT ORIGINAL_NAME FROM DBA_RECYCLEBIN WHERE TS_NAME = 'TEST';

ORIGINAL_NAME
--------------------------------
TEST2
TEST3
TEST4
TEST5
TEST6
TEST7
TEST8
TEST9
TEST10
TEST11
TEST12
TEST13
TEST14
TEST15
TEST16
TEST17
TEST19
 

-- Determine the the amount of data remaining in active extents in the TEST tablespace datafile

SELECT SUM(BYTES) FROM DBA_EXTENTS WHERE FILE_ID = 5;

SUM(BYTES)
----------
10485760

-- Remember .. when resizing datafiles smaller .. extra space should be allowed for future growth as well as space for the datafile headers
--      this test was run with an overhead of 10 (8K) blocks

-- Determine what objects must be moved in order for the resize to succeed

@SHRINK_DATAFILE.SQL

Enter value for file_id: 5
old 6: V_FILE_ID := &FILE_ID;
new 6: V_FILE_ID := 5;
Enter value for resize_file_to: 10567680
old 7: V_RESIZE_SIZE := &RESIZE_FILE_TO;
new 7: V_RESIZE_SIZE := 10567680;
.
.
.
Objects in File 5 that must move in order to resize the file to 10567680 BYTES
=================================================
TEST.TEST18 - OBJECT TYPE = TABLE

-- Show that the resize will not succeed with the objects in their present position

ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/v10205/test.dbf' RESIZE 10567680;

ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/v10205/test.dbf' RESIZE 10567680
*
ERROR at line 1:
ORA-03297: file contains used data beyond requested RESIZE value

-- Move the TEST18 table to another tablespace so that the resize can succeed

ALTER TABLE TEST18 MOVE TABLESPACE USERS;

-- Attempt to resize the table again

ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/v10205/test.dbf' RESIZE 10567680;

ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/v10205/test.dbf' RESIZE 10567680
*
ERROR at line 1:
ORA-03297: file contains used data beyond requested RESIZE value

-- The reason that this resize failed is there are still objects in the recycle bin ... they need to removed before the resize can succeed

purge tablespace test;

-- Tablespace purged.

-- Attempt the resize again

ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/v10205/test.dbf' RESIZE 10567680;

-- Database altered.

select bytes from v$datafile where file# = 5;

BYTES
----------
10567680

!ls -alt /u01/app/oracle/oradata/v10205/test.dbf

-rw-r----- 1 oracle dba 10575872 Apr 20 06:19 /u01/app/oracle/oradata/v10205/test.dbf



-- Return the TEST18 table to the TEST tablespace

ALTER TABLE TEST18 MOVE TABLESPACE TEST;


-- CLEAN UP

CONNECT / AS SYSDBA
drop user test cascade;
drop tablespace test including contents and datafiles cascade constraints;

 

B. Approach 2
-- Temp Table Creation

-------------------------------------------------------------------------
-- 1. Create a temporary table from dba_exents so it can be queried more
-- efficiently. Modify tablespace for suit. This is mainly for single
-- file_id
-------------------------------------------------------------------------

spool segment_block_position_in _dbfile.log
set pages 10000;
set linesize 420;

create global temporary table reorg_extents on commit preserve rows as
select x.*, rownum as "ERID" from (select dba_extents.*, block_id + blocks -1 as "EXTLEN"
from dba_extents
where file_id
in (select file_id
from dba_data_files
where tablespace_name='&Tablespace_Name')
order by block_id asc) x;

The above Query would copy the extent information to a temp table for a specified tablespace (SYSAUX used in this example). 

-- Identify Free Gaps 

---------------------------------------------------------------------------
-- 2. This script will identify any free space gaps in extents that can be used
-- for the tablespace
----------------------------------------------------------------------------

col owner format a10;
col segment_name format a30;

with gaps as (
select e1.owner, e1.segment_name, e1.partition_name, e1.segment_type, e1.block_id, e1.blocks, e1.extlen, e1.erid, 'MAX' as "BOUND"
from reorg_extents e1
where block_id -1 not in ( select e2.extlen from reorg_extents e2)
and erid !=1)
select gp.*, '<=============>' as "GAPSZ" from gaps gp
union
select e2.owner, e2.segment_name, e2.partition_name, e2.segment_type, e2.block_id, e2.blocks, e2.extlen, e2.erid, 'MIN' as "BOUND",
'EMPTY BLOCKS => '||(g.block_id-e2.extlen-1) as "GAPSZ"
from reorg_extents e2, gaps g
where e2.erid = g.erid -1
order by 7 asc
;

 

Sample Ouput

OWNER  SEGMENT_NAME               PARTITION_NAME            SEGMENT_TYPE    BLOCK_ID BLOCKS EXTLEN ERID BOU GAPSZ
----- -------------------------- ------------------------- ---------------- -------- ---------- ---------- ------------------
SYS WRH$_EVENT_HISTOGRAM_PK      WRH$_EVENT__4023503584_188 INDEX PARTITION  54472      8    54479 4620 MIN EMPTY BLOCKS => 8
SYS WRH$_SQL_PLAN                                           TABLE            54488      8    54495 4621 MAX <================>
SYS WRH$_SYSMETRIC_HISTORY_INDEX                            INDEX            54504      8    54511 4623 MIN EMPTY BLOCKS => 8
SYS WRH$_SQLTEXT                                            TABLE            54520      8    54527 4624 MAX <================>
SYS WRH$_SQLTEXT                                            TABLE            54520      8    54527 4624 MIN EMPTY BLOCKS => 8
SYS WRH$_SYSMETRIC_HISTORY                                  TABLE            54536      8    54543 4625 MAX <================>

..

SYS I_WRI$_OPTSTAT_H_ST                                     INDEX            58880     128   59007 4921 MIN EMPTY BLOCKS => 8
SYS SYS_LOB0000006213C00038$$                               LOBSEGMENT       59016      8    59023 4922 MAX <================>
SYS SCHEDULER$_JOB_RUN_DETAILS                              TABLE            59800      8    59807 4975 MIN EMPTY BLOCKS => 96
SYS WRI$_OPTSTAT_HISTGRM_HISTORY                            TABLE            59904     128   60031 4976 MAX <================>

The ouput shows that there is free space of about 8 blocks between the segment WRH$_EVENT_HISTOGRAM_PK and WRH$_SQL_PLAN and same way between WRH$_SQL_PLAN and WRH$_SYSMETRIC_HISTORY_INDEX. The number of free blocks is shown in GAPSZ column.

 From the above Query,we can identiy the Gaps that are inbetween the objects.

-- Identify the Extents that are in last 10 positions in the datafile.

----------------------------------------------------------------------------
-- 3. This will give the total size of segments that contain any extents
-- in the end 10 positions in the given datafile, so some of these will probably
-- have to be moved to shrink the datafile depending on where they are
-- So the segment may have some extents at the start and the end of a datafile
-- though the whole segment obviously needs moving.
----------------------------------------------------------------------------
col partition_name format a30;
select * from (
select s.owner, s.segment_name, s.partition_name, s.segment_type, s.blocks, s.extents, e.erid
from dba_segments s, (select * from reorg_extents where erid in (select max(erid) from reorg_extents group by owner, segment_name,
partition_name, segment_type) order by erid asc) e
where s.owner=e.owner
and s.segment_name=e.segment_name
and s.partition_name=e.partition_name
order by e.erid desc)
where rownum < 11;
spool off;

Sample Ouput

OWNER SEGMENT_NAME           PARTITION_NAME              SEGMENT_TYPE     BLOCKS EXTENTS ERID
----- -------------------- ---------------------------- -------------- - ------- ------- -----
SYS   WRH$_SYSSTAT           WRH$_SYSSTA_4023503584_188   TABLE PARTITION   56      7   4974
SYS   WRH$_LATCH_PK          WRH$_LATCH_4023503584_188    INDEX PARTITION   56      7   4973
SYS   WRH$_SERVICE_STAT      WRH$_SERVIC_4023503584_188   TABLE PARTITION   16      2   4972
SYS   WRH$_SQLSTAT           WRH$_SQLSTA_4023503584_188   TABLE PARTITION   72      9   4968
SYS   WRH$_PARAMETER_PK      WRH$_PARAME_4023503584_188   INDEX PARTITION   40      5   4967
SYS   WRH$_SYSSTAT_PK        WRH$_SYSSTA_4023503584_188   INDEX PARTITION   64      8   4966
SYS   WRH$_LATCH             WRH$_LATCH_4023503584_188    TABLE PARTITION   88      11  4965
SYS   WRH$_PARAMETER         WRH$_PARAME_4023503584_188   TABLE PARTITION   48      6   4963
SYS   WRH$_SYSSTAT_PK        WRH$_SYSSTA_4023503584_165   INDEX PARTITION   64      8   4960
SYS   WRH$_ROWCACHE_SUMMARY  WRH$_ROWCAC_4023503584_165   TABLE PARTITION   16      2   4959

The Above query list the segment information whose extents are in last 10 positions in the database. We can either reorganize (move/ export) / shrink the objects to release those extents at the end of datafile. After that we can resize the datafile. We can also recursively perform this action to reorganize the objects subject to its limitations and to release the freespace at the datafile level.

 
