/*

ORA-19815: WARNING: db_recovery_file_dest_size of 4385144832 bytes is 100.00% used, and has 0 remaining bytes available.
Errors in file /u01/app/oracle/diag/rdbms/cognostst/cognostst/trace/cognostst_arc0_21671.trc:

Problem occured because of the archive log destination size was fulled in order to solve this problem;

*/


SQL> set lines 299
SQL> select * from v$flash_recovery_area_usage
  2  ;

FILE_TYPE	     PERCENT_SPACE_USED PERCENT_SPACE_RECLAIMABLE NUMBER_OF_FILES
-------------------- ------------------ ------------------------- ---------------
CONTROL FILE			      0 			0		0
REDO LOG			      0 			0		0
ARCHIVED LOG			  99.68 			0	       96
BACKUP PIECE			      0 			0		0
IMAGE COPY			      0 			0		0
FLASHBACK LOG			      0 			0		0
FOREIGN ARCHIVED LOG		      0 			0		0


select  name, 
floor(space_limit / 1024 / 1024) ,  
ceil(space_used  / 1024 / 1024)  
from  v$recovery_file_dest;

NAME                               (SPACE_LIMIT/1024/1024)  CEIL(SPACE_USED/1024/1024)
/u01/app/oracle/fast_recovery_area	4301	                  4301


SQL> alter system set db_recovery_file_dest_size = 7764M scope = both;

System altered.

SQL> select * from v$flash_recovery_area_usage;

FILE_TYPE	     PERCENT_SPACE_USED PERCENT_SPACE_RECLAIMABLE NUMBER_OF_FILES
-------------------- ------------------ ------------------------- ---------------
CONTROL FILE			      0 			0		0
REDO LOG			      0 			0		0
ARCHIVED LOG			   55.4 			0	       99
BACKUP PIECE			      0 			0		0
IMAGE COPY			      0 			0		0
FLASHBACK LOG			      0 			0		0
FOREIGN ARCHIVED LOG		      0 			0		0



select  name, 
floor(space_limit / 1024 / 1024) ,  
ceil(space_used  / 1024 / 1024)  
from  v$recovery_file_dest;

NAME                               (SPACE_LIMIT/1024/1024)  CEIL(SPACE_USED/1024/1024)
/u01/app/oracle/fast_recovery_area	7764	                  4301

