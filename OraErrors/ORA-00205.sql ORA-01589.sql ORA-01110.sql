--after changing control file with new one this error occurs

SQL> shutdown immediate;
--ORA-01507: database not mounted


ORACLE instance shut down.

SQL> create pfile from spfile;

--File created.

SQL>  create spfile from pfile;

--File created.


SQL> alter system set control_files='/u01/app/oracle/oradata/xxx/control03.ctl' scope=spfile;

--System altered.

SQL> startup
ORACLE instance started.

Total System Global Area 3221225472 bytes
Fixed Size		    8625856 bytes
Variable Size		 2801795392 bytes
Database Buffers	  402653184 bytes
Redo Buffers		    8151040 bytes
Database mounted.
ORA-01589: must use RESETLOGS or NORESETLOGS option for database open


SQL> alter database open resetlogs;
alter database open resetlogs
*
ERROR at line 1:
ORA-01113: file 1 needs media recovery
ORA-01110: data file 1: '/u01/app/oracle/oradata/murat/system01.dbf'



SQL> startup mount;
ORACLE instance started.

Total System Global Area 3221225472 bytes
Fixed Size		    8625856 bytes
Variable Size		 2801795392 bytes
Database Buffers	  402653184 bytes
Redo Buffers		    8151040 bytes
Database mounted.
SQL> SELECT MEMBER FROM V$LOG G, V$LOGFILE F WHERE G.GROUP# = F.GROUP# AND G.STATUS = 'CURRENT';

MEMBER
--------------------------------------------------------------------------------
/u01/app/oracle/oradata/murat/redo03.log

SQL> RECOVER DATABASE USING BACKUP CONTROLFILE UNTIL CANCEL;
ORA-00279: change 9651594 generated at 08/15/2019 11:00:55 needed for thread 1
ORA-00289: suggestion : /u01/fra/oradata/orcl/arch/1_262_1008264416.dbf
ORA-00280: change 9651594 for thread 1 is in sequence #262


Specify log: {<RET>=suggested | filename | AUTO | CANCEL}
/u01/app/oracle/oradata/murat/redo03.log
Log applied.
Media recovery complete.
SQL> alter database open resetlogs;

Database altered.

SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.


SQL> startup
ORACLE instance started.

Total System Global Area 3221225472 bytes
Fixed Size		    8625856 bytes
Variable Size		 2801795392 bytes
Database Buffers	  402653184 bytes
Redo Buffers		    8151040 bytes
Database mounted.
Database opened.
SQL> 








