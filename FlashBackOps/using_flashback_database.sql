-----FLASBACK DATABASE EXAMPLE-----

create table bbenzer.employees2 tablespace users as select * from bbenzer.employees;

create table bbenzer.employees3 tablespace users as select * from bbenzer.employees;


select TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual;
--TO_CHAR(SYSDATE,'YY
-------------------
--2019-11-13 11:10:30


SQL> delete from bbenzer.employees;
SQL> drop table bbenzer.employees2;
SQL> drop table bbenzer.employees3;

SQL> shutdown immediate;
SQL> startup mount;


SQL> flashback database to timestamp TO_TIMESTAMP('2019-11-13 11:10:30','YYYY-MM-DD HH24:MI:SS');

Flashback complete.

SQL> alter database open resetlogs;

Database altered.

SQL> Select count (*) from bbenzer.employees
  2  ;

--  COUNT(*)
----------
--	23
