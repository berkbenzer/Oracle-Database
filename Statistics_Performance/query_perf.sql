
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


-- Gather Statistics Specific Schema
EXEC DBMS_STATS.gather_schema_stats('SCHEMA_NAME');

EXEC DBMS_STATS.gather_database_stats;
EXEC DBMS_STATS.gather_dictionary_stats;



-- Checks jobs in progress 
 select * from dba_optstat_operations where status = 'IN PROGRESS' order by start_time desc;

-- Displays stastics of the Schema
 SELECT owner, table_name, stats_update_time
     FROM dba_tab_stats_history
     WHERE 1=1 
     AND owner='SCHEMA_NAME'
     --AND table_name='DM_SYSOBJECT_R'
     ORDER BY owner, table_name, stats_update_time DESC
     
