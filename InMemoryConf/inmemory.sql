SQL> alter system set inmemory_size=2G scope=spfile;

System altered.

SQL> create pfile ='/tmp/init.ora' from spfile

SQL> startup pfile='/tmp/init.ora'
ORACLE instance started.

Total System Global Area 5100273664 bytes
Fixed Size		    8631240 bytes
Variable Size		 2868907064 bytes
Database Buffers	   67108864 bytes
Redo Buffers		    8142848 bytes
In-Memory Area		 2147483648 bytes
Database mounted.
Database opened.


SQL> ALTER SYSTEM REGISTER; 

System altered.


