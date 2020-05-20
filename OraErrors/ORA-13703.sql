 ALTER SYSTEM SET AWR_PDB_AUTOFLUSH_ENABLED=TRUE;

--Set the AWR snapshot interval greater than 0 in the PDB using the command as shown in the following example:

EXEC dbms_workload_repository.modify_snapshot_settings(interval=>20);
