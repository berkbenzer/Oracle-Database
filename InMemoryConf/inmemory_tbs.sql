CREATE TABLESPACE new_ts
   DATAFILE '/u01/arch/users4.dbf' SIZE 10M 
   DEFAULT INMEMORY;
   
   
   
   
   
      SELECT tablespace_name, 
       def_inmemory,
       def_inmemory_priority,
       def_inmemory_distribute,
       def_inmemory_compression,
       def_inmemory_duplicate
FROM   dba_tablespaces
ORDER BY tablespace_name;
