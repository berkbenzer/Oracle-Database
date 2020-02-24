####CALIBRATION######



/*

The procedure must be called by a user with the SYSDBA priviledge.
TIMED_STATISTICS must be set to TRUE, which is the default when STATISTICS_LEVEL is set to TYPICAL.
Datafiles must be accessed using asynchronous I/O. This is the default when ASM is used.
You can check your current asynchronous I/O setting for your datafiles using the following query.


*/

SELECT d.name,
       i.asynch_io
FROM   v$datafile d,
       v$iostat_file i
WHERE  d.file# = i.file_no
AND    i.filetype_name  = 'Data File';



--To turn on asynchronous I/O, issue the following command and restart the database.

ALTER SYSTEM SET filesystemio_options=setall SCOPE=SPFILE;


SELECT d.name,
       i.asynch_io
FROM   v$datafile d,
       v$iostat_file i
WHERE  d.file# = i.file_no
AND    i.filetype_name  = 'Data File';





SET SERVEROUTPUT ON
DECLARE
  l_latency  PLS_INTEGER;
  l_iops     PLS_INTEGER;
  l_mbps     PLS_INTEGER;
BEGIN
   DBMS_RESOURCE_MANAGER.calibrate_io (num_physical_disks => 1, 
                                       max_latency        => 20,
                                       max_iops           => l_iops,
                                       max_mbps           => l_mbps,
                                       actual_latency     => l_latency);
 
  DBMS_OUTPUT.put_line('Max IOPS = ' || l_iops);
  DBMS_OUTPUT.put_line('Max MBPS = ' || l_mbps);
  DBMS_OUTPUT.put_line('Latency  = ' || l_latency);
END;
/



SET LINESIZE 100
COLUMN start_time FORMAT A20
COLUMN end_time FORMAT A20

SELECT TO_CHAR(start_time, 'DD-MON-YYY HH24:MI:SS') AS start_time,
       TO_CHAR(end_time, 'DD-MON-YYY HH24:MI:SS') AS end_time,
       max_iops,
       max_mbps,
       max_pmbps,
       latency,
       num_physical_disks AS disks
FROM   dba_rsrc_io_calibrate;



