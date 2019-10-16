/*DAILY */
  SELECT TRUNC (COMPLETION_TIME, 'DD') Day,
         thread#,
         ROUND (SUM (BLOCKS * BLOCK_SIZE) / 1024 / 1024 / 1024) GB,
         COUNT (*) Archives_Generated
    FROM v$archived_log
GROUP BY TRUNC (COMPLETION_TIME, 'DD'), thread#
ORDER BY 1;


/* HOURLY */
  SELECT TRUNC (COMPLETION_TIME, 'HH') Hour,
         thread#,
         ROUND (SUM (BLOCKS * BLOCK_SIZE) / 1024 / 1024 / 1024) GB,
         COUNT (*) Archives
    FROM v$archived_log
GROUP BY TRUNC (COMPLETION_TIME, 'HH'), thread#
ORDER BY 1;
