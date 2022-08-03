

##Indexes
SELECT table_name, index_name, to_char(last_analyzed,'DD-MON-YYYY HH24:MI:SS') "LASTANALYZED" FROM DBA_INDEXES;

##tables
select table_name, to_char(last_analyzed,'DD-MON-YYYY HH24:MI:SS') from dba_tables;


##col
SELECT table_name,column_name,to_char(last_analyzed,'DD-MON-YYYY HH24:MI:SS') "LASTANALYZED" from DBA_TAB_COL_STATISTICS;
