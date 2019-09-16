
--single table
impdp FILE=T_PAYMENT.dmp  TABLES=T_PAYMENT_INFO_DMP


exp \'/ as sysdba\' file=/oracle/yedek/audit_27032019.dmp log=/oracle/yedek/audit_27032019.log tables=sys.aud$



exp '/ as sysdba' file=xxx_07122017.dmp log=xxx_07122017.log OWNER=TEST GRANTS=y ROWS=y

imp '/ as sysdba' file=full64_07.12.2017.dmp log=full64_07.12.2017_imp.log fromuser=TEST touser=TEST ignore=y 


expdp directory=pump dumpfile=XX0205.dmp logfile=XX0205.log schemas=XXX flashback_scn=11274316701577 estimate=statistics exclude=table:"in\('T_X1'\,'X2'\,'T_X2'\,'T_X3'\)"
