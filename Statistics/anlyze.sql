

##Indexes
/* Formatted on 8/3/2022 10:04:56 AM (QP5 v5.269.14213.34769) */
  SELECT idx.owner,table_name,
         index_name,
         last_analyzed,
         SUM(bytes)/1024/1024/1024 GB,
         TO_CHAR (last_analyzed, 'DD-MON-YYYY') "LASTANALYZED"
         --TO_CHAR (last_analyzed, 'DD-MON-YYYY HH24:MI:SS') "LASTANALYZED"
    FROM DBA_INDEXES idx, dba_segments seg
    where 1=1
    and idx.index_name = SEG.SEGMENT_NAME
    and idx.owner != 'SYS'
    GROUP BY idx.index_name, idx.table_name,last_analyzed,idx.owner
    ORDER BY GB DESC;


##tables
select table_name, to_char(last_analyzed,'DD-MON-YYYY HH24:MI:SS') from dba_tables;


##col
SELECT table_name,column_name,to_char(last_analyzed,'DD-MON-YYYY HH24:MI:SS') "LASTANALYZED" from DBA_TAB_COL_STATISTICS;
