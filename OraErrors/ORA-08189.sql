/*

ORA-08189: Cannot Flashback The Table Because Row Movement Is Not Enabled


*/

flashback table ORDERS.test  to timestamp systimestamp - interval '1' hour;

select table_name,ROW_MOVEMENT from dba_tables where table_name='TEST'

ALTER TABLE ORDERS.TEST ENABLE ROW MOVEMENT ;
