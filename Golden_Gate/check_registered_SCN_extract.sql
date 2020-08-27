--after linux machine crashed Goldengate Throws and error missing logfile
-- check registered SCN to extract
select * from dba_registered_archived_log where first_scn =11318303184541;


 Select sequence# from v$archived_log where sequence# > 11318303184541;



GGSCI (linuxhostname) 3> DBLOGIN USERID OGG@DB_NAME PASSWORD XXXXX
Successfully logged into database.

GGSCI (linuxhostname as OGG@DB_NAME1) 4> İNFO ALL
ERROR: Invalid command.

GGSCI (linuxhostname as OGG@DB_NAME1) 5> info all

Program     Status      Group       Lag at Chkpt  Time Since Chkpt

MANAGER     RUNNING                                           
EXTRACT     STARTING    E3PROC    00:00:03      26:38:21    
EXTRACT     STARTING    E7PROC    00:00:03      26:38:20    
EXTRACT     RUNNING     P3PROC    00:00:00      00:00:08    
EXTRACT     RUNNING     P7PROC    00:00:00      00:00:02    


GGSCI (linuxhostname as OGG@DB_NAME1) 6> STOP EXTRACT E3PROC

Sending STOP request to EXTRACT E3PROC ...




ERROR: sending message to EXTRACT E3PROC (Timeout waiting for message).


GGSCI (linuxhostname as OGG@DB_NAME1) 7> 
GGSCI (linuxhostname as OGG@DB_NAME1) 7> 
GGSCI (linuxhostname as OGG@DB_NAME1) 7> 
GGSCI (linuxhostname as OGG@DB_NAME1) 7> info all

Program     Status      Group       Lag at Chkpt  Time Since Chkpt

MANAGER     RUNNING                                           
EXTRACT     STARTING    E3PROC    00:00:03      26:39:35    
EXTRACT     STARTING    E7PROC    00:00:03      26:39:34    
EXTRACT     RUNNING     P3PROC    00:00:00      00:00:02    
EXTRACT     RUNNING     P7PROC    00:00:00      00:00:06    


GGSCI (linuxhostname as OGG@DB_NAME1) 8> UNREGISTER EXTRACT E3PROC DATABASE
Successfully unregistered EXTRACT E3PROC from database.


GGSCI (linuxhostname as OGG@DB_NAME1) 9> REGISTER EXTRACT E3PROC DATABASE
Extract E3PROC successfully registered with database at SCN 11318308835473.


GGSCI (linuxhostname as OGG@DB_NAME1) 10> info all

Program     Status      Group       Lag at Chkpt  Time Since Chkpt

MANAGER     RUNNING                                           
EXTRACT     ABENDED     E3PROC    00:00:03      26:41:57    
EXTRACT     ABENDED     E7PROC    00:00:03      26:41:56    
EXTRACT     RUNNING     P3PROC    00:00:00      00:00:04    
EXTRACT     RUNNING     P7PROC    00:00:00      00:00:08    


GGSCI (linuxhostname as OGG@DB_NAME1) 11> start EXTRACT E3PROC

Sending START request to MANAGER ...
EXTRACT E3PROC starting

