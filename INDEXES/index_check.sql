 
SELECT owner,
       index_name
FROM   dba_indexes
WHERE  1=1 
AND OWNER='XXX'
AND    status NOT IN ('VALID', 'N/A')
ORDER BY owner, index_name


SELECT index_owner, index_name, partition_name, tablespace_name
FROM   dba_ind_PARTITIONS
WHERE  status = 'UNUSABLE';


SELECT index_owner, index_name, partition_name, subpartition_name, tablespace_name
FROM   dba_ind_SUBPARTITIONS
WHERE  status = 'UNUSABLE';

--------------------------------

--Fixing broken indexes

SELECT 'alter index '||owner||'.'||index_name||' rebuild tablespace '||tablespace_name ||';' sql_to_rebuild_index
FROM   dba_indexes
WHERE  status = 'UNUSABLE';
Index partitions:

SELECT 'alter index '||index_owner||'.'||index_name ||' rebuild partition '||PARTITION_NAME||' TABLESPACE '||tablespace_name ||';' sql_to_rebuild_index
FROM   dba_ind_partitions
WHERE  status = 'UNUSABLE';
Index subpartitions:

SELECT 'alter index '||index_owner||'.'||index_name ||' rebuild subpartition '||SUBPARTITION_NAME||' TABLESPACE '||tablespace_name ||';' sql_to_rebuild_index
FROM   dba_ind_subpartitions
WHERE  status = 'UNUSABLE';
or if you prefer via single PLSQL anonymous block:

set serveroutput on size unlimited

BEGIN
	FOR x IN
	(
		SELECT 'ALTER INDEX '||OWNER||'.'||INDEX_NAME||' REBUILD ONLINE PARALLEL' comm
		FROM    dba_indexes
		WHERE   status = 'UNUSABLE'
		UNION ALL
		SELECT 'ALTER INDEX '||index_owner||'.'||index_name||' REBUILD PARTITION '||partition_name||' ONLINE PARALLEL'
		FROM    dba_ind_PARTITIONS
		WHERE   status = 'UNUSABLE'
		UNION ALL
		SELECT 'ALTER INDEX '||index_owner||'.'||index_name||' REBUILD SUBPARTITION '||subpartition_name||' ONLINE PARALLEL'
		FROM    dba_ind_SUBPARTITIONS
		WHERE   status = 'UNUSABLE'
	)
	LOOP
		dbms_output.put_line(x.comm);
		EXECUTE immediate x.comm;
	END LOOP;
END;
/
