--guarantee option if the fra is full oracle hold write proccess in database
--

SQL> create restore point DB_IS_OK guarantee flashback database;
Restore point created.
SQL> delete from bbenzer.employees;
--23 rows deleted.
SQL> delete from bbenzer.employees2;
--23 rows deleted.
SQL> delete from bbenzer.employees3;    
--23 rows deleted

SQL> column NAME format a30
SQL> column REST_TIME format a30
SQL> select SCN, NAME, to_char(TIME,'DD-MON-YYYY HH24:MI:SS') as RES_TIME from v$restore_point;

     SCN NAME 			  RES_TIME
---------- ------------------------------ --------------------
   1749732 DB_IS_OK			  13-NOV-2019 12:44:39
   
SQL> flashback database to restore point DB_IS_OK;
Flashback complete.
SQL> alter database open resetlogs;
Database altered.
SQL> Select count (*) from bbenzer.employees
union all
Select count (*) from bbenzer.employees2
union all
Select count (*) from bbenzer.employees3;  2    3    4    5  

  COUNT(*)
----------
	23
	23
	23
--NEED Drop restore point, if not fra will be full quickly
SQL> drop restore point db_is_ok;
Restore point dropped.
