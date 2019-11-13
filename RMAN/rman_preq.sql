SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.

SQL> startup mount;
ORACLE instance started.
Total System Global Area 3774873600 bytes
Fixed Size		    8627440 bytes
Variable Size		  872418064 bytes
Database Buffers	 2885681152 bytes
Redo Buffers		    8146944 bytes
Database mounted.

SQL> archive log list;
Database log mode	       No Archive Mode
Automatic archival	       Disabled
Archive destination	       USE_DB_RECOVERY_FILE_DEST
Oldest online log sequence     1
Current log sequence	       1
SQL> alter database archivelog;
Database altered.

SQL> show parameter db_recovery_file_dest;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
db_recovery_file_dest		     string	 /u01/app/oracle/fast_recovery_area/testdb
db_recovery_file_dest_size	     big integer 8016M

SQL> alter database open;
Database altered.

SQL> ALTER SYSTEM SET DB_RECOVERY_FILE_DEST_SIZE=15G SCOPE=BOTH;
System altered.

SQL>  show parameter db_recovery_file_dest;
NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
db_recovery_file_dest		     string	 /u01/app/oracle/fast_recovery_area/testdb
db_recovery_file_dest_size	     big integer 15G
SQL> 
