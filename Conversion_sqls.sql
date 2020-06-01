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
