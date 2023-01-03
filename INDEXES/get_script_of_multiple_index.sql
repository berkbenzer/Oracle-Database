
### get multiple index script ###

SELECT    'select DBMS_METADATA.GET_DDL("INDEX", "'
       || index_name
       || '","'
       || owner
       || '") from dual;'
  FROM dba_indexes
 WHERE table_name = 'TABLE_NAME';
