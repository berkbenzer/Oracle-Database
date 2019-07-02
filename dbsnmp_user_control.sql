Set old password as a new password to DBSNMP user in order to collect data from oracle instance to Cloud Control


--Need to check expired users which should be DBSNMP
select username, account_status from dba_users where 1=1
AND ACCOUNT_STATUS = 'EXPIRED'


--lock'ı kaldırma scripti hazırlanır
select 'alter user "'||d.username||'" identified by values '''||u.password||''';' from dba_users d, sys.user$ u where d.username = upper('&&username') and u.user# = d.user_id;

--Eski şifresiyle user alter edilir em manager agent'ı tekrardan restart edilir
alter user "DBSNMP" identified by values 'XXXXX';
