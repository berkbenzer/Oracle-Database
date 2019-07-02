CREATE OR REPLACE PROCEDURE truncate_table  IS
BEGIN
EXECUTE IMMEDIATE 'SYSAUTH$1';
END truncate_table;
/



BEGIN
dbms_scheduler.create_job(
job_name => 'SYS_AUDIT_TRUNC'
,job_type => 'PLSQL_BLOCK'
,job_action =>  'begin truncate_table; end;'
,repeat_interval => 'FREQ=MONTHLY; BYMONTHDAY=-1;'
,enabled => TRUE);
END;
