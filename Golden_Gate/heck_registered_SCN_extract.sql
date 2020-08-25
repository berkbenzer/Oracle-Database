
-- check registered SCN to extract
select * from dba_registered_archived_log where first_scn =11318303184541;


 Select sequence# from v$archived_log where sequence# > 11318303184541;
