SQL> startup;
ORACLE instance started.

Total System Global Area 3774873600 bytes
Fixed Size		    8627440 bytes
Variable Size		 2315258640 bytes
Database Buffers	 1442840576 bytes
Redo Buffers		    8146944 bytes
Database mounted.
ORA-03113: end-of-file on communication channel
Process ID: 4563
Session ID: 9 Serial number: 42188





SQL>  startup nomount
ORACLE instance started.

Total System Global Area 3774873600 bytes
Fixed Size		    8627440 bytes
Variable Size		 2315258640 bytes
Database Buffers	 1442840576 bytes
Redo Buffers		    8146944 bytes
SQL>  alter database mount;

Database altered.

SQL>  alter database clear unarchived logfile group 1;

Database altered.

SQL> alter database clear unarchived logfile group 2;

Database altered.

SQL> alter database clear unarchived logfile group 3;

Database altered.

SQL> shutdown immediate
ORA-01109: database not open


Database dismounted.
ORACLE instance shut down.
SQL> startup
ORACLE instance started.

Total System Global Area 3774873600 bytes
Fixed Size		    8627440 bytes
Variable Size		 2315258640 bytes
Database Buffers	 1442840576 bytes
Redo Buffers		    8146944 bytes
Database mounted.
Database opened.
SQL> ^C
