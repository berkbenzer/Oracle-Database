select group#,members,status,bytes/1024/1024 as mb from v$log;


select group#,member from v$logfile;


alter database add logfile ('/u01/app/oracle/oradata/xxx/redo12.log' ) size 4096m;


--/u01/app/oracle/oradata/xx/redo07.log

alter system switch logfile;

alter system checkpoint;

alter database drop logfile group 1;
