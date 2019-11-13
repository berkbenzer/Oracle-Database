select file_name from dba_data_files;

--/u01/app/oracle/oradata/TESTDB/datafile/

--create new tablespace
CREATE TABLESPACE test_tbs DATAFILE '/u01/app/oracle/oradata/TESTDB/datafile/test01.dbf' size 100m autoextend on;

--create table in new tbs
create table bbenzer.employees (emp_id number(10), emp_name varchar2(50)) tablespace test_tbs;

--enable row movement
alter table bbenzer.employees enable row movement;

--insert data 
insert into bbenzer.employees (emp_id, emp_name) values (1, 'Lewiss Willerstone');
insert into bbenzer.employees (emp_id, emp_name) values (2, 'Sabrina Hutable');
insert into bbenzer.employees (emp_id, emp_nsame) values (3, 'Silva Collacombe');
.
.
.
--wait a minute add new data
insert into bbenzer.employees  (emp_id, emp_name) values (22, 'hayda');
insert into bbenzer.employees  (emp_id, emp_name) values (23, 'hoppa');
insert into bbenzer.employees  (emp_id, emp_name) values (24, 'hııı');
insert into bbenzer.employees  (emp_id, emp_name) values (25, 'ayıptır');
insert into bbenzer.employees  (emp_id, emp_name) values (26, 'ajann');
insert into bbenzer.employees  (emp_id, emp_name) values (27, 'müdür');
insert into bbenzer.employees  (emp_id, emp_name) values (28, 'muhtar');
insert into bbenzer.employees  (emp_id, emp_name) values (29, 'taylor100ce');



select * from bbenzer.employees;
--31 rows

--flashback table 500 seconds ago
FLASHBACK TABLE bbenzer.employees TO TIMESTAMP (SYSTIMESTAMP - INTERVAL '500' second);

select count(*) from bbenzer.employees;
--23
