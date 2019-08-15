SQL> shutdown immediate;
 ORA-01109: database not open
 Database dismounted.
 ORACLE instance shut down.
SQL> startup mount;
 ORACLE instance started.
 Total System Global Area 7917113344 bytes
 Fixed Size 2198064 bytes
 Variable Size 3976201680 bytes
 Database Buffers 3925868544 bytes
 Redo Buffers 12845056 bytes
 Database mounted.

--Following query will help to retrieve name of the current redo log files, i.e. redo log belongs to active group.

SQL> SELECT MEMBER FROM V$LOG G, V$LOGFILE F WHERE G.GROUP# = F.GROUP# AND G.STATUS = 'CURRENT';
 MEMBER
 --------------------------------------------------------------------------------
 /oracle/<oracle_sid>/origlogA/log_g17m1.dbf
 /oracle/<oracle_sid>/mirrlogA/log_g17m2.dbf
Above redo files will help to recover database.

--Recover your database with the help of following command, when oracle suggested for non existing archive log with full path (i.e. invalid file) Ignore it and provide above redo log file as an input.
--Note: There is no file available on specified path. i.e. <oracle_sid>arch1_66606_758161962.dbf

 SQL> RECOVER DATABASE USING BACKUP CONTROLFILE UNTIL CANCEL;
 ORA-00279: change 1041939961 generated at 08/11/2014 16:31:04 needed for thread 1
 ORA-00289: suggestion : /oracle/<oracle_sid>/oraarch/<oracle_sid>arch1_66606_758161962.dbf
 ORA-00280: change 1041939961 for thread 1 is in sequence #66606
 Specify log: {=suggested | filename | AUTO | CANCEL}
 /oracle/<oracle_sid>/origlogA/log_g17m1.dbf
 Log applied.
 Media recovery complete.

--Media recovery completed successfully, While backup with controlfile OR in case of incomplete recovery, you need to open your database with reset-logs, its recommended.

 SQL> alter database open resetlogs;
 Database altered.
SQL> SQL> select open_mode from v$database;
 OPEN_MODE
 --------------------
 READ WRITE
