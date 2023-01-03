### get single index script ###
select dbms_metadata.get_ddl ('INDEX', 'EMP_EMAIL_UK', 'HR') from dual;


### get multiple index script ###

SELECT    'select DBMS_METADATA.GET_DDL("INDEX", "'
       || index_name
       || '","'
       || owner
       || '") from dual;'
  FROM dba_indexes
 WHERE table_name = 'TABLE_NAME';
