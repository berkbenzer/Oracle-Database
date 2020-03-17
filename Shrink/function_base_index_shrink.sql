ORA-10631: SHRINK clause should not be specified for this object


select owner, index_name, index_type
from dba_indexes
where index_type like 'FUNCTION-BASED%'
and owner not in ('XDB','SYS','SYSTEM') and table_name='XXXX'


/*
OWNER   INDEX_NAME    INDEX_TYPE
-----   ----------    ----------
XXX	    INDEX_NAME_1	FUNCTION-BASED NORMAL
*/


select table_name,index_name,column_expression
from dba_ind_expressions
where index_name ='INDEX_NAME_1';

/*
TABLE_NAME   INDEX_NAME    COLUMN_EXPRESSION
-----        ----------    ----------
XXX	         INDEX_NAME_1	 (WIDEMEMO)
*/

--GET INDEX SOURCE CODE
select dbms_metadata.get_ddl('INDEX','INDEX_NAME_1','XXX') from dual;


/*
Drop index and shrink it

*/
