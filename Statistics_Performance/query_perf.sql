
SET SERVEROUTPUT ON
declare
stmt_task VARCHAR2(40);
begin
stmt_task := DBMS_SQLTUNE.CREATE_TUNING_TASK(sql_id => 'SQL_ID',
                                             task_name => 'TEST_sql_tuning_task_2'
);
DBMS_OUTPUT.put_line('task_id: ' || stmt_task );
end;
/

select * from dba_advisor_log where task_name ='TEST_sql_tuning_task_2'; 


Execute dbms_sqltune.Execute_tuning_task (task_name => 'TEST_sql_tuning_task_2');


set long 65536
set longchunksize 65536
set linesize 100
select dbms_sqltune.report_tuning_task('TEST_sql_tuning_task_2') from dual;



EXEC DBMS_STATS.gather_schema_stats('SCHEMA_NAME');

EXEC DBMS_STATS.gather_database_stats;
EXEC DBMS_STATS.gather_dictionary_stats;
