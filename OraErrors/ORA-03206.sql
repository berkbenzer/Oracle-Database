/*
This happens when the max size parameter is bigger than the block size. 

*/

ALTER TABLESPACE UNDOTBS1
  ADD DATAFILE '/u01/app/oracle/oradata/ODS/undotbs08.dbf'
  SIZE 12288M
  AUTOEXTEND ON
  NEXT 100M
  MAXSIZE 32768;

ALTER TABLESPACE UNDOTBS1
  ADD DATAFILE '/u01/app/oracle/oradata/ODS/undotbs08.dbf'
  SIZE 12288M
  AUTOEXTEND ON
  NEXT 100M
  MAXSIZE 31744;
