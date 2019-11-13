
SQL> SHOW PARAMETER UNDO_RETENTION;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
undo_retention			     integer	 900
SQL> 

--THE BIGGER THE UNDO THE BIGGER SIZE REQUERMENTS UNDO TABLESPACE
SQL> ALTER SYSTEM SET UNDO_RETENTION=9000 SCOPE=BOTH;

System altered.

----------FLASHBACK DATABASE PREREQ----------

/*
First need to shutdown instance

*/


SQL> shutdown immediate;
SQL> startup mount;
ORACLE instance started.

Total System Global Area 3774873600 bytes
Fixed Size		    8627440 bytes
Variable Size		  872418064 bytes
Database Buffers	 2885681152 bytes
Redo Buffers		    8146944 bytes

SQL> archive log list;
Database log mode	       Archive Mode
Automatic archival	       Enabled
Archive destination	       USE_DB_RECOVERY_FILE_DEST
Oldest online log sequence     1
Next log sequence to archive   2
Current log sequence	       2

 
--need to configuıre db_recovery_file_dest
SQL> show parameter db_recovery_file_dest;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
db_recovery_file_dest		     string	 /u01/app/oracle/fast_recovery_
						 area/testdb
db_recovery_file_dest_size	     big integer 15G
SQL> 


SQL> show parameter db_flashback_retention_target;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
db_flashback_retention_target	     integer	 1440
SQL> 

SQL> alter database flashback on;

Database altered.

SQL> alter database open;
