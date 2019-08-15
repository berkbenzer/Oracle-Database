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

