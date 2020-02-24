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
