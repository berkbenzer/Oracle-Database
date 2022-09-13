--- job history



  SELECT *
    FROM dba_autotask_job_history
   WHERE     1 = 1
         AND job_start_time > SYSTIMESTAMP - 14
         AND job_status = 'STOPPED'
ORDER BY job_start_time DESC;
