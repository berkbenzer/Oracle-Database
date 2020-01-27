CREATE PLUGGABLE DATABASE appcon1 AS APPLICATION CONTAINER ADMIN USER app_admin IDENTIFIED BY "oracle";

/*
CREATE PLUGGABLE DATABASE appcon1 AS APPLICATION CONTAINER ADMIN USER app_admin IDENTIFIED BY "oracle"
Error at line 4
ORA-65016: FILE_NAME_CONVERT belirtilmelidir

Script Terminated on line 4.
*/


select FILE_NAME from dba_data_files;

/*
/u01/app/oracle/oradata/CNDB/system01.dbf
/u01/app/oracle/oradata/CNDB/sysaux01.dbf
/u01/app/oracle/oradata/CNDB/undotbs01.dbf
/u01/app/oracle/oradata/CNDB/users01.dbf
*/

CREATE PLUGGABLE DATABASE appcon1 AS APPLICATION CONTAINER ADMIN USER app_admin IDENTIFIED BY "oracle"
FILE_NAME_CONVERT= ('/u01/app/oracle/oradata/CNDB/','/u01/app/oracle/oradata/CNDB/app_con1')   --add file convert


ALTER PLUGGABLE DATABASE appcon1 OPEN;
