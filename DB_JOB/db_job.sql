select * from  all_scheduler_job_run_details
where 1=1
and owner='XXX'
AND STATUS ='SUCCEEDED'


SELECT *
FROM DBA_SCHEDULER_JOB_RUN_DETAILS
where 1=1
and owner='XXXX'
--AND 
ORDER BY LOG_DATE DESC;


  SELECT DSJ.STATE, DSJ.LAST_START_DATE, DSJ.*
    FROM dba_scheduler_jobs DSJ
   WHERE     1 = 1
         AND DSJ.OWNER = 'XXX'
         AND TRUNC (DSJ.LAST_START_DATE) = TO_DATE ('10/04/2019', 'MM/DD/YYYY')
ORDER BY DSJ.LAST_START_DATE DESC
