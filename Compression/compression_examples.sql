--Generic Compressed Tablespace

CREATE TABLESPACE compdef
DATAFILE '/u01/arch/compressed.dbf' SIZE 10M
AUTOEXTEND ON
DEFAULT COMPRESS;


CREATE TABLESPACE compall



DATAFILE '/u01/arch/compall.dbf' SIZE 10M
AUTOEXTEND ON
DEFAULT COMPRESS FOR ALL OPERATIONS;



CREATE TABLESPACE compdir
DATAFILE '/u01/arch/compdir.dbf' SIZE 10M
AUTOEXTEND ON
DEFAULT COMPRESS FOR DIRECT_LOAD OPERATIONS;


SELECT tablespace_name, def_tab_compression AS DEF_TAB_COMP, compress_for AS COMP_FOR,
       def_inmemory_compression AS DEF_INMEM_COMP, def_index_compression AS DEF_IND_COMP,
       index_compress_for AS IND_COMP
FROM dba_tablespaces
WHERE tablespace_name NOT LIKE 'APEX%'
AND tablespace_name <> 'TEMP'
ORDER BY 1;


--Advanced OLTP Compression for Table



CREATE TABLESPACE compoltp
DATAFILE '/u01/arch/compoltp.dbf' SIZE 10M
AUTOEXTEND ON
DEFAULT COMPRESS FOR OLTP;


SELECT tablespace_name, def_tab_compression AS DEF_TAB_COMP, compress_for AS COMP_FOR,
       def_inmemory_compression AS DEF_INMEM_COMP, def_index_compression AS DEF_IND_COMP,
       index_compress_for AS IND_COMP
FROM dba_tablespaces
WHERE tablespace_name NOT LIKE 'APEX%'
AND tablespace_name <> 'TEMP'
and DEF_TAB_COMPRESSION='ENABLED'
ORDER BY 1;
