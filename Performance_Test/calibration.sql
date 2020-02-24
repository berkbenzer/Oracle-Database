####CALIBRATION######



/*
DISKS
MAX_LATENCY
We recommend setting both parameters. 
DISKS define the number of disks that we have in our LUN or LUNs.
With new storage array technologies and huge LUNs this can be challenging to count. In this case a good starting point is 20.

The MAX_LATENCY is a cool feature, as we discussed in our observations, it allows for setting a latency cap.

Here is our sample run of MAX_LATENCY set to 20 and DISKS set to 20. This is a good test to start with before tweaking the settings.
*/



SET SERVEROUTPUT ON

DECLARE

lat  INTEGER;

iops INTEGER;

mbps INTEGER;

BEGIN

-- DBMS_RESOURCE_MANAGER.CALIBRATE_IO (, <MAX_LATENCY>, iops, mbps, lat);
DBMS_RESOURCE_MANAGER.CALIBRATE_IO (20, 20, iops, mbps, lat);     DBMS_OUTPUT.PUT_LINE ('max_iops = ' || iops);

DBMS_OUTPUT.PUT_LINE ('latency  = ' || lat);

dbms_output.put_line('max_mbps = ' || mbps);

end;

/




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



