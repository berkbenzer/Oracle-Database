-----FLASHBACK DROP OBJECTS------

SQL> SHOW PARAMETER RECYCLEBIN;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
recyclebin		

SQL> DROP TABLE bbenzer.employees
  2  ;

Table dropped.

SQL> select count(*) from bbenzer.employees;
select count(*) from bbenzer.employees
                             *
ERROR at line 1:
ORA-00942: table or view does not exist


SQL> FLASHBACK TABLE BBENZER.EMPLOYEES TO BEFORE DROP;
Flashback complete.

SQL> select count(*) from bbenzer.employees;

  COUNT(*)
----------
	23
