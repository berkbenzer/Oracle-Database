SELECT
  DSP.GRANTEE,DSP.PRIVILEGE,DU.ACCOUNT_STATUS
FROM
  DBA_SYS_PRIVS dsp,  SYS.DBA_USERS du
  where 1=1
  and DSP.GRANTEE = DU.USERNAME
  and du.account_status= 'OPEN'
  and du.username not in ('SYS','SYSTEM','DBSAT','APPDBCONN')
 -- AND du.username ='BBENZER'
  group by GRANTEE,PRIVILEGE,DU.ACCOUNT_STATUS
  ORDER BY 1
;


select * from v$pwfile_users;

select * from dba_role_privs where granted_role='DBA';
