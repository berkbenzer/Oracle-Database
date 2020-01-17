select * from dba_hist_wr_control;

exec dbms_workload_repository.modify_snapshot_settings(interval => 30, retention => 44640) ;


select * from dba_hist_wr_control;
