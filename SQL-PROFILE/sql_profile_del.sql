select * from DBA_SQL_PROFILES;


BEGIN 
  DBMS_SQLTUNE.DROP_SQL_PROFILE ( 
     name            =>  'SYS_SQLPROF_025cbf55ca3b0000'
  
);
END;
