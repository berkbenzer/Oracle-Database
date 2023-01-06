
--single table
impdp FILE=T_PAYMENT.dmp  TABLES=T_PAYMENT_INFO_DMP

expdp \"SYS@SERVICE  as sysdba\" file=TAB_06012023.dmp log=TAB_06012023.log tables=SCHEMA.TABLE


exp \'/ as sysdba\' file=/oracle/yedek/audit_27032019.dmp log=/oracle/yedek/audit_27032019.log tables=sys.aud$


--Full Schema
exp '/ as sysdba' file=xxx_07122017.dmp log=xxx_07122017.log OWNER=TEST GRANTS=y ROWS=y

imp '/ as sysdba' file=full64_07.12.2017.dmp log=full64_07.12.2017_imp.log fromuser=TEST touser=TEST ignore=y 


expdp directory=pump dumpfile=XX0205.dmp_%U logfile=XX0205.log schemas=XXX flashback_scn=11274316701577 estimate=statistics exclude=table:"in\('T_X1'\,'X2'\,'T_X2'\,'T_X3'\)"



expdp file=XXX13092019.dmp log=XXX13092019 OWNER=XXX directory=DATA_PUMP_DIR GRANTS=y ROWS=y


expdp dumpfile=LF6092019.dmp_%U log=LF16092019 OWNER=LF directory=DATA_PUMP_DIR GRANTS=y ROWS=y

-- Remap schema
impdp system DIRECTORY=DATA_PUMP_DIR DUMPFILE=XXX13092019.dmp REMAP_SCHEMA=SOURCE_SCHEMA_NAME:NEW_SCHEMA_NAME

-- Single table
expdp directory=DATA_PUMP_DIR dumpfile=table_name.dmp%U logfile=table_name.log tables=bnppko.table_name
impdp file=xxx.dmp log=xxx.log tables=<schema_name>.<table_name>

--Multiple Table
expdp dumpfile=initload2.dmp logfile=initload2.log directory=DATA_PUMP_DIR tables=XXX.X1,XXX.X1

-- Remap Tablespace
impdp dumpfile=initload2.dmp logfile=imp_initialload.log directory=DATA_PUMP_DIR remap_tablespace=TS_XX:USERS
