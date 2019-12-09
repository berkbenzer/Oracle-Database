--finde historical executed sql statements

SELECT v.SQL_TEXT,
       v.PARSING_SCHEMA_NAME,
       v.FIRST_LOAD_TIME,
       v.DISK_READS,
       v.ROWS_PROCESSED,
       v.ELAPSED_TIME,
       v.service
  FROM V$SQL V
 WHERE TO_DATE (v.FIRST_LOAD_TIME, 'YYYY-MM-DD hh24:mi:ss') > SYSDATE - 4
 AND v.Sql_text like 'SELECT%'
 ORDER BY V.FIRST_LOAD_TIME ASC
