SQL> alter database begin backup;

Database altered.

SQL> select name from v$datafile;

NAME
--------------------------------------------------------------------------------
/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_system_gwnsh452_.dbf
/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_sysaux_gwnsj7dx_.dbf
/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_undotbs1_gwnsk0h7_.dbf
/u01/app/oracle/oradata/TESTDB/datafile/o1_mf_users_gwnsk1kb_.dbf


--after moving files another destination or the snapshot process finish you need to end the backup mode

SQL> alter database end backup;

Database altered.

--BACKUP CONTROL FILE

SQL> select name from v$controlfile;

NAME
--------------------------------------------------------------------------------
/u01/app/oracle/oradata/TESTDB/controlfile/o1_mf_gwnskz5v_.ctl
/u01/app/oracle/fast_recovery_area/testdb/TESTDB/controlfile/o1_mf_gwnskz6z_.ctl


SQL> alter database backup controlfile to '/u01/fra/backups/control_file_backup.ctl';

Database altered.


------ this command allows you archive redo log files
SQL> alter system archive log current;

System altered.


SQL> select thread#,sequence#, name from v$archived_log;

SQL> select thread#,sequence#, name from v$archived_log;

   THREAD#  SEQUENCE#
---------- ----------
NAME
--------------------------------------------------------------------------------
	 1	    1
/u01/app/oracle/fast_recovery_area/testdb/TESTDB/archivelog/2019_11_12/o1_mf_1_1
_gwnv6zm0_.arc

	 1	    2
/u01/app/oracle/fast_recovery_area/testdb/TESTDB/archivelog/2019_11_12/o1_mf_1_2
_gwnw0zrf_.arc

	 1	    3

   THREAD#  SEQUENCE#
---------- ----------
NAME
--------------------------------------------------------------------------------
/u01/app/oracle/fast_recovery_area/testdb/TESTDB/archivelog/2019_11_12/o1_mf_1_3
_gwnw149y_.arc

	 1	    4
/u01/app/oracle/fast_recovery_area/testdb/TESTDB/archivelog/2019_11_12/o1_mf_1_4
_gwnw1m6p_.arc

	 1	    5
/u01/app/oracle/fast_recovery_area/testdb/TESTDB/archivelog/2019_11_12/o1_mf_1_5

   THREAD#  SEQUENCE#
---------- ----------
NAME
--------------------------------------------------------------------------------
_gwnw1yb6_.arc

	 1	    6
/u01/app/oracle/fast_recovery_area/testdb/TESTDB/archivelog/2019_11_12/o1_mf_1_6
_gwnw42w4_.arc

	 1	    7
/u01/app/oracle/fast_recovery_area/testdb/TESTDB/archivelog/2019_11_12/o1_mf_1_7
_gwnw4csr_.arc

   THREAD#  SEQUENCE#
---------- ----------
NAME
--------------------------------------------------------------------------------


7 rows selected.
----------------------------------------------------
