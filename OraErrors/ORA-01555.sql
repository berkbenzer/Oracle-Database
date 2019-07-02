
/*
Scripts that take time in database causes this Error.
This is related with the Undo_Retention parametre, Size is smaller than the scripts need.
In order to solve this problem

1- Need to find UNDO_SIZE,UNDO_RETENTION and OPTIMUM_UNDO_RETENTION parameters.
2- Calculate the needed Undo_Size
3- Check the error count
4- Increase UNDO_TABLESPACE size with adding datafile

*/

--1
SELECT d.undo_size/(1024*1024) as UNDO_SIZE,
       SUBSTR(e.value,1,25) as UNDO_RETENTION,
       ROUND((d.undo_size / (to_number(f.value) *
       g.undo_block_per_sec))) as OPTIMUM_UNDO_RETENTION
  FROM (
       SELECT SUM(a.bytes) undo_size
          FROM v$datafile a,
               v$tablespace b,
               dba_tablespaces c
         WHERE c.contents = 'UNDO'
           AND c.status = 'ONLINE'
           AND b.name = c.tablespace_name
           AND a.ts# = b.ts#
       ) d,
       v$parameter e,
       v$parameter f,
       (
       SELECT MAX(undoblks/((end_time-begin_time)*3600*24))
              undo_block_per_sec
         FROM v$undostat
       ) g
WHERE e.name = 'undo_retention'
  AND f.name = 'db_block_size';
  
  --2
    SELECT d.undo_size/(1024*1024) as UNDO_SIZE,
       SUBSTR(e.value,1,25) as UNDO_RETENTION,
       (TO_NUMBER(e.value) * TO_NUMBER(f.value) *
       g.undo_block_per_sec) / (1024*1024)
      as NEEDED_UNDO_SIZE
  FROM (
       SELECT SUM(a.bytes) undo_size
         FROM v$datafile a,
              v$tablespace b,
              dba_tablespaces c
        WHERE c.contents = 'UNDO'
          AND c.status = 'ONLINE'
          AND b.name = c.tablespace_name
          AND a.ts# = b.ts#
       ) d,
      v$parameter e,
       v$parameter f,
       (
       SELECT MAX(undoblks/((end_time-begin_time)*3600*24))
         undo_block_per_sec
         FROM v$undostat
       ) g
 WHERE e.name = 'undo_retention'
  AND f.name = 'db_block_size';
  
  --3
SQL> show parameter UNDO;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
undo_management 		     string	 AUTO
undo_retention			     integer	 14400
undo_tablespace 		     string	 UNDOTBS1
SQL> alter system set undo_retention = 18000;

System altered.

SQL> show parameter UNDO;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
undo_management 		     string	 AUTO
undo_retention			     integer	 18000
undo_tablespace 		     string	 UNDOTBS1
SQL> 

  
  --4 
  ALTER TABLESPACE UNDOTBS1
  ADD DATAFILE '/u01/app/oracle/oradata/ODS/undotbs07.dbf'
  SIZE 100M
  AUTOEXTEND ON
  NEXT 100M
  MAXSIZE 32G;
  
  
