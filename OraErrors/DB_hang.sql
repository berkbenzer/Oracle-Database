


SQL> shutdown immediate;
Database closed.
Database dismounted.


after the shutdown command db dismounted but not closed

alert.log
Completed: ALTER DATABASE CLOSE NORMAL
ALTER DATABASE DISMOUNT
Shutting down archive processes
Archiving is disabled
Completed: ALTER DATABASE DISMOUNT
ARCH: Archival disabled due to shutdown: 1089
Shutting down archive processes
Archiving is disabled
ARCH: Archival disabled due to shutdown: 1089
Shutting down archive processes
Archiving is disabled
Sun Jul 26 02:39:05 2020
Stopping background process VKTM   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< hang here


it takes time shutdown.
