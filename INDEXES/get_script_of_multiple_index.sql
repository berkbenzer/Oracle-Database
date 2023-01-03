-- get single index script 
select dbms_metadata.get_ddl ('INDEX', 'EMP_EMAIL_UK', 'HR') from dual;

-- return select script of each index

SELECT    'select DBMS_METADATA.GET_DDL("INDEX", "'
       || index_name
       || '","'
       || owner
       || '") from dual;'
  FROM dba_indexes
 WHERE table_name = 'TABLE_NAME';

-- Get each Index Script for the specific table
 select DBMS_METADATA.GET_DDL('INDEX', INDEX_NAME, OWNER) from DBA_INDEXES WHERE TABLE_NAME='TABLE_NAME' AND OWNER LIKE '%';
