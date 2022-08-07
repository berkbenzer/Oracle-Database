/* Formatted on 8/7/2022 11:45:51 AM (QP5 v5.269.14213.34769) */
SELECT TO_CHAR (begin_interval_time, 'YYYY_MM_DD HH24') WHEN,
       DBMS_LOB.SUBSTR (sql_text, 4000, 1) SQL,
       dhss.instance_number INST_ID,
       dhss.sql_id,
       executions_delta exec_delta,
       rows_processed_delta rows_proc_delta
  FROM dba_hist_sqlstat dhss, dba_hist_snapshot dhs, dba_hist_sqltext dhst
 WHERE     1 = 1
       --and UPPER (dhst.sql_text) LIKE '%<segment_name>%'
       AND LTRIM (UPPER (dhst.sql_text)) NOT LIKE 'SELECT%'
       AND dhss.snap_id = dhs.snap_id
       AND dhss.instance_number = dhs.instance_number
       AND dhss.sql_id = dhst.sql_id
       AND begin_interval_time BETWEEN TO_DATE ('22-08-05 13:00',
                                                'YY-MM-DD HH24:MI')
                                   AND TO_DATE ('22-08-07 14:00',
                                                'YY-MM-DD HH24:MI')
