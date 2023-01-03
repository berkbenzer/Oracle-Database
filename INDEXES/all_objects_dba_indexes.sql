### Check index name which tablesspace is located ###
set linesize 200;
column INDEX_NAME format a30;
column OWNER format a30;
column TABLE_OWNER format a30;
column TABLESPACE_NAME format a30;
column LAST_ANALYZED format a15;
column CREATED format a15;



SELECT DI.OWNER,
       DI.INDEX_NAME,
       DI.TABLESPACE_NAME,
       DI.LAST_ANALYZED,
       AO.CREATED
  FROM ALL_OBJECTS AO, dba_indexes DI
 WHERE     1 = 1
       AND AO.OBJECT_NAME = DI.INDEX_NAME
       AND DI.TABLE_NAME = 'NEGOTIATION';
