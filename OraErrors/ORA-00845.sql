
alter system set memory_max_target= 3069M SCOPE = SPFILE;

alter system set memory_target= 3069M SCOPE = SPFILE;



shutdown immediate;
--Database closed.
--Database dismounted.
--ORACLE instance shut down.

startup
--ORA-00845: MEMORY_TARGET not supported on this system



--SOLUTION



~]$ df -h /dev/shm
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           1.9G   72K  1.9G   1% /dev/shm


~]$ mount -t tmpfs shmfs -o size=4g /dev/shm


SQL> startup
ORACLE instance started.

Total System Global Area 3221225472 bytes
Fixed Size		    8625856 bytes
Variable Size		 2801795392 bytes
Database Buffers	  402653184 bytes
Redo Buffers		    8151040 bytes
Database mounted.
Database opened.
SQL> 
