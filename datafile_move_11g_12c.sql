--11g



ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/murat/users02.dbf' OFFLINE;


mv '/u01/app/oracle/oradata/murat/users02.dbf' '/u01/arch/users2.dbf'

ALTER DATABASE RENAME FILE '/u01/app/oracle/oradata/murat/users02.dbf' TO '/u01/arch/users2.dbf';

ALTER DATABASE RECOVER DATAFILE '/u01/arch/users2.dbf';

ALTER DATABASE DATAFILE '/u01/arch/users2.dbf' online;


--12c 

ALTER DATABASE MOVE DATAFILE '/u01/app/oracle/oradata/cdb1/system01.dbf' TO '/tmp/system01.dbf';
