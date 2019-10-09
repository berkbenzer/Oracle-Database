--Check DataGuard Status

--check the alert.log if the Standby database is opened in READ ONLY mode and if the MRP process is started

ALTER DATABASE RECOVER MANAGED STANDBY DATABASE [ options ]; will start the MRP process

-- run the following query on the Standby database, for example:

 select open_mode, controlfile_type from v$database;

/*
OPEN_MODE CONTROLFILE
----------------------------------------------
READ ONLY WITH APPLY STANDBY
*/
