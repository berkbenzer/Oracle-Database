select * from (
  select LAST_LOAD_TIME, to_char(ELAPSED_TIME/1000, '999,999,999.000') || ' ms' as TIME,
         MODULE, SQL_TEXT from V$SQL
    where SQL_ID in( 'c8vyq1tanqg7m', 'bhsv7ss5af8d6')
    order by LAST_LOAD_TIME desc
  ) where ROWNUM <= 5;
  
  
  
    SELECT ss.snap_id,
         ss.instance_number node,
         begin_interval_time,
         sql_id,
         plan_hash_value,
         NVL (executions_delta, 0) execs,
           (  elapsed_time_delta
            / DECODE (NVL (executions_delta, 0), 0, 1, executions_delta))
         / 1000000
            avg_etime,
         (  buffer_gets_delta
          / DECODE (NVL (buffer_gets_delta, 0), 0, 1, executions_delta))
            avg_lio
    FROM DBA_HIST_SQLSTAT S, DBA_HIST_SNAPSHOT SS
   WHERE     sql_id IN ('c8vyq1tanqg7m')
         AND ss.snap_id = S.snap_id
         AND ss.instance_number = S.instance_number
         AND executions_delta > 0
ORDER BY 1, 2, 3
