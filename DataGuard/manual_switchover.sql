onnect to proddb database via client: Take a new putty session and connect to proddb database via client machine. Keep querying below

sqlplus sys/sys@proddb as sysdba

SQL> select name, open_mode, db_unique_name, database_role from v$database;

NAME      OPEN_MODE            DB_UNIQUE_NAME                 DATABASE_ROLE
--------- -------------------- ------------------------------ --------------
proddb    READ WRITE           proddb                         PRIMARY

Check primary and standby for any gaps

On primary:
===========
SQL> select STATUS, GAP_STATUS from V$ARCHIVE_DEST_STATUS where DEST_ID = 2;

On standby:
===========
SQL> select NAME, VALUE, DATUM_TIME from V$DATAGUARD_STATS;

Convert primary to standby: We will first convert primary to standby and later standby to primary

On primary:
===========
SQL> select SWITCHOVER_STATUS from V$DATABASE;

You must see TO STANDBY or SESSIONS ACTIVE

SQL> alter database commit to switchover to physical standby with session shutdown;

SQL> startup mount;

Execute query on client: At this stage, there is no primary to accept queries from client. Run below query on client putty terminal. The query will hang and wait until standby is converted to primary

SQL> select name, open_mode, db_unique_name, database_role from v$database;

Convert standby to primary: Our primary is already converted to standby. Now it’s time to convert original standby into primary

SQL> select SWITCHOVER_STATUS from V$DATABASE;
SQL> alter database commit to switchover to primary with session shutdown;
SQL> alter database open;

Check client query: Check the query you executed in step 4 on client, it must get executed

On new standby – Initially your primary database: Start MRP

SQL> alter database recover managed standby database disconnect;
