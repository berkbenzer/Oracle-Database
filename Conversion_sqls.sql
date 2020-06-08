--NTIMESTAMP#	31			Y	TIMESTAMP(6)		None	14030848	0	0	

select * from  sys.aud$ AUD
where AUD.userid='XXXX'
and trunc(AUD.NTIMESTAMP#) > TO_DATE('09/20/2019','MM/DD/YYYY')
;



select * from  sys.aud$ AUD
where AUD.userid='XXXX'
and trunc(AUD.NTIMESTAMP#) > TO_DATE('09/20/2019 5:00:00','MM/DD/YYYY HH:MI:SS')
;


  SELECT to_char (DHA.SAMPLE_TIME, 'dd/mm/yyyy'), du.username,count(DHA.SAMPLE_TIME)
    FROM DBA_HIST_ACTIVE_SESS_HISTORY dha, dba_users du
   WHERE     dha.user_id = du.user_id
         AND dha.user_id = 90
         AND TRUNC (SAMPLE_TIME) > TO_DATE ('28/05/2020', 'dd/mm/yyyy')       
GROUP BY to_char (DHA.SAMPLE_TIME, 'dd/mm/yyyy'), du.username
ORDER BY 1 ASC


-- every 5 min display who connects DB
  SELECT   TRUNC (timestamp, 'hh24')
         + TRUNC (TO_CHAR (timestamp, 'mi') / 10) * 5 / 1440 as COLUMN1,
         COUNT (*)
    FROM DBA_AUDIT_TRAIL
   WHERE     UPPER (USERNAME) IN ('XXXX')
         AND TO_CHAR (TIMESTAMP, 'yyyy') NOT IN ('2017', 2018, 2019)
GROUP BY   TRUNC (timestamp, 'hh24')
         + TRUNC (TO_CHAR (timestamp, 'mi') / 10) * 5 / 1440
         order by COLUMN1 ASC
