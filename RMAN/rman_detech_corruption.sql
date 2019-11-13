--checks datafile corruption


RMAN> validate database check logical;


File Status Marked Corrupt Empty Blocks Blocks Examined High SCN
---- ------ -------------- ------------ --------------- ----------
1    OK     0              17444        102401          1456941   
  File Name: /u01/app/oracle/oradata/TESTDB/datafile/o1_mf_system_gwnsh452_.dbf
  Block Type Blocks Failing Blocks Processed
  ---------- -------------- ----------------
  Data       0              67646           
  Index      0              12517           
  Other      0              4793        
  
--it validates backup set is there any corruption  
RMAN> validate backupset 24;

Starting validate at 12-NOV-19
using channel ORA_DISK_1
channel ORA_DISK_1: starting validation of datafile backup set
channel ORA_DISK_1: reading from backup piece /u01/app/oracle/fast_recovery_area/testdb/TESTDB/backupset/2019_11_12/o1_mf_nnndf_TAG20191112T192907_gwotz3jx_.bkp
channel ORA_DISK_1: piece handle=/u01/app/oracle/fast_recovery_area/testdb/TESTDB/backupset/2019_11_12/o1_mf_nnndf_TAG20191112T192907_gwotz3jx_.bkp tag=TAG20191112T192907
channel ORA_DISK_1: restored backup piece 1
channel ORA_DISK_1: validation complete, elapsed time: 00:00:01
Finished validate at 12-NOV-19
