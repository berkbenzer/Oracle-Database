  SELECT owner,
         job_name,
         log_date,
         status,
         actual_start_date,
         run_duration,
         cpu_used
    FROM dba_scheduler_job_run_details
   WHERE 1 = 1 AND OWNER = 'XXXX'


select * from  all_scheduler_job_run_details
where 1=1
and owner='XXX'
AND STATUS ='SUCCEEDED'
ORDER BY ACTUAL_START_DATE DESC

SELECT *
FROM DBA_SCHEDULER_JOB_RUN_DETAILS
where 1=1
and owner='XXXX'
ORDER BY LOG_DATE DESC;

--RUNNING JOBS
  SELECT DSJ.STATE, DSJ.LAST_START_DATE, DSJ.*
    FROM dba_scheduler_jobs DSJ
   WHERE     1 = 1
         AND DSJ.OWNER = 'XXXX'
         AND TRUNC (DSJ.LAST_START_DATE) = TO_DATE ('02/17/2020', 'MM/DD/YYYY')
         AND DSJ.STATE='RUNNING'
ORDER BY DSJ.LAST_START_DATE DESC

SELECT *
FROM DBA_SCHEDULER_JOB_RUN_DETAILS
where 1=1
and owner='XXX'
AND TRUNC (ACTUAL_START_DATE) = TO_DATE ('11/04/2019', 'MM/DD/YYYY')
ORDER BY 2 DESC
