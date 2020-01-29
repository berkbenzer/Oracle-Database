--NTIMESTAMP#	31			Y	TIMESTAMP(6)		None	14030848	0	0	

select * from  sys.aud$ AUD
where AUD.userid='XXXX'
and trunc(AUD.NTIMESTAMP#) > TO_DATE('09/20/2019','MM/DD/YYYY')
;



select * from  sys.aud$ AUD
where AUD.userid='XXXX'
and trunc(AUD.NTIMESTAMP#) > TO_DATE('09/20/2019 5:00:00','MM/DD/YYYY HH:MI:SS')
;

