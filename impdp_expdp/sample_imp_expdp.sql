
--single table
impdp FILE=T_PAYMENT.dmp  TABLES=T_PAYMENT_INFO_DMP


exp \'/ as sysdba\' file=/oracle/yedek/audit_27032019.dmp log=/oracle/yedek/audit_27032019.log tables=sys.aud$



exp '/ as sysdba' file=xxx_07122017.dmp log=xxx_07122017.log OWNER=TEST GRANTS=y ROWS=y

imp '/ as sysdba' file=full64_07.12.2017.dmp log=full64_07.12.2017_imp.log fromuser=TEST touser=TEST ignore=y 
