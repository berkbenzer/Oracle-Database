
SQL> select name, open_mode, database_role from v$database;
NAME      OPEN_MODE  DATABASE_ROLE
——— ———- —————-
MYDB   READ WRITE PRIMARY


--On Standby Server.

SQL> select name, open_mode, database_role from v$database;
NAME      OPEN_MODE  DATABASE_ROLE
——— ———- —————-
MYDB   MOUNTED    PHYSICAL STANDBY


--Step 2 : Check for GAP on Standby
PRIMARY@MYDB>select max(sequence#) from v$log_history;


STANDBY@SQL>select max(sequence#) from v$log_history;


STANDBY@SQL>SELECT THREAD# "Thread",SEQUENCE# "Last Sequence Generated"
FROM V$ARCHIVED_LOG
WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#)
ORDER BY 1;
 

--Step 3 & 4: Check redo received and applied on standby. 

STANDBY@SQL> SELECT ARCH.THREAD# “Thread”, ARCH.SEQUENCE# “Last Sequence Received”,
APPL.SEQUENCE# “Last Sequence Applied”, (ARCH.SEQUENCE# – APPL.SEQUENCE#) “Difference”
FROM
(SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN
(SELECT THREAD#,MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#)) ARCH,
(SELECT THREAD# ,SEQUENCE# FROM V$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN
(SELECT THREAD#,MAX(FIRST_TIME) FROM V$LOG_HISTORY GROUP BY THREAD#)) APPL
WHERE
ARCH.THREAD# = APPL.THREAD#
ORDER BY 1;


