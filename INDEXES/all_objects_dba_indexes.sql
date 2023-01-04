### Check index name which tablesspace is located ###
set linesize 200;
column INDEX_NAME format a30;
column OWNER format a30;
column TABLE_OWNER format a30;
column TABLESPACE_NAME format a30;
column LAST_ANALYZED format a15;
column CREATED format a15;
column bytes format a10;



  SELECT DI.OWNER,
         DI.INDEX_NAME,
         DI.TABLESPACE_NAME,
         DI.LAST_ANALYZED,
         AO.CREATED,
         ROUND (SUM (bytes) / 1024 / 1024 / 1024, 2) GB
    FROM ALL_OBJECTS AO, dba_indexes DI, dba_segments seg
   WHERE     1 = 1
         AND AO.OBJECT_NAME = DI.INDEX_NAME
         AND di.owner = seg.owner
         AND di.index_name = seg.segment_name
         AND DI.TABLE_NAME = 'TABLE_NAME'
GROUP BY DI.OWNER,
         DI.INDEX_NAME,
         DI.TABLESPACE_NAME,
         DI.LAST_ANALYZED,
         AO.CREATED
ORDER BY GB DESC
