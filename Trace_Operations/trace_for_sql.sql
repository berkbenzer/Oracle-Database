/*
Create Trace Files
Files will be created under the trace location with related DB instance
*/


alter session set tracefile_identifier='10046_10053_<<DB_NAME>>';
alter session set timed_statistics = true;
alter session set statistics_level=all;
alter session set max_dump_file_size = unlimited;
alter session set events '10046 trace name context forever,level 12';
alter session set events '10053 trace name context forever, level 1';

/*Put select statement here */

select 'Verify Close' from dual;
alter session set events '10046 trace name context off';
alter session set events '10053 trace name context off';







/*First check the Statistic are stale or not */

SELECT table_name,
       partition_name,
       num_rows,
       TO_CHAR (last_analyzed, 'DD-MON-YYYY HH24:MI:SS') "Last",
       stale_stats
  FROM dba_tab_statistics
 WHERE table_name = 'TABLE_NAME';
 
 /*Find SQL ID*/
  SELECT sql_id, plan_hash_value, substr(sql_text,1,40) sql_text  
FROM  v$sql 
WHERE sql_text like '<<SQL_TEXT>>'


/*
SQLHC DOWNLOAD AND RUN
Connect to SQLPLUS and run the command with SQL_ID
*/

start /home/oracle/sqlhc/sqlhc.sql -T <<SQL_ID>>;

