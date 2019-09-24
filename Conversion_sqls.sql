--NTIMESTAMP#	31			Y	TIMESTAMP(6)		None	14030848	0	0	

select * from  sys.aud$ AUD
where AUD.userid='BESPROD'
and trunc(AUD.NTIMESTAMP#) > TO_DATE('09/20/2019','MM/DD/YYYY')
;
