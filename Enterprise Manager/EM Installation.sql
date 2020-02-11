--EM MANAGER 13C INSTALL

--download files https://www.oracle.com/enterprise-manager/downloads/linux-x86-64-13c-rel3-downloads.html

 rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE}(%{ARCH})\n" | grep glibc-dev
 
 
:/u01/oem13c]# ll
total 9497120
-rw-r--r--. 1 oracle oinstall 1742204641 Nov 27 15:24 em13300_linux64-2.zip
-rw-r--r--. 1 oracle oinstall 2090882426 Nov 27 15:27 em13300_linux64-3.zip
-rw-r--r--. 1 oracle oinstall 2117436260 Nov 28 09:39 em13300_linux64-4.zip
-rw-r--r--. 1 oracle oinstall  694002559 Nov 27 15:56 em13300_linux64-5.zip
-rw-r--r--. 1 oracle oinstall 1801995711 Nov 28 09:26 em13300_linux64-6.zip
-rwxrwxrwx. 1 oracle oinstall 1278491093 Nov 28 09:17 em13300_linux64.bin
[oracle@test:/u01/oem13c]# 



[oracle@test:/u01/oem13c]# chmod 777 em13300_linux64.bin

[oracle@test:/u01/oem13c]# ./em13300_linux64.bin

alter system set "_optimizer_nlj_hj_adaptive_join"= FALSE scope=both sid='*'; 
alter system set "_optimizer_strans_adaptive_pruning" = FALSE scope=both sid='*';
 alter system set "_px_adaptive_dist_method" = OFF scope=both sid='*';
 alter system set "_sql_plan_directive_mgmt_control" = 0 scope=both sid='*';
 alter system set "_optimizer_dsdir_usage_control" = 0 scope=both sid='*';
 alter system set "_optimizer_use_feedback" = FALSE scope=both sid='*';
 alter system set "_optimizer_gather_feedback" = FALSE scope=both sid='*';
 alter system set "_optimizer_performance_feedback" = OFF scope=both sid='*';
 
 
 BEGIN
  DBMS_AUTO_TASK_ADMIN.DISABLE(
    client_name => 'auto optimizer stats collection',
    operation => NULL,
    window_name => NULL);
END;
/



SQL> show parameter _allow_insert;
SQL> show parameter compatible;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
compatible			     string	 12.2.0
noncdb_compatible		     boolean	 FALSE
SQL> alter system set "_allow_insert_with_update_check" = true;

System altered.

SQL> show parameter PARALLEL_MAX_SERVERS 

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
parallel_max_servers		     integer	 160
SQL> alter system set PARALLEL_MAX_SERVERS = 0 scope= both;

System altered.


#Prerequisite Recommendation = Temporarily disabling the gather stats job
SQL>




SQL> alter system set PARALLEL_MIN_SERVERS= 0 scope=both;

System altered.

begin
for c in (select sid, serial# from v$session) loop
   dbms_system.set_int_param_in_session(c.sid,c.serial#,'session_cached_cursors', 300);
end loop;
end;
/

SQL> alter system set shared_pool_size=2G scope=both; 

System altered.

SQL> show parameter shared_pool_size;

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
shared_pool_size		     big integer 2G
SQL> 





--before connect need setglobalport to Enable
SQL> exec dbms_xdb_config.SetGlobalPortEnabled(TRUE);

PL/SQL procedure successfully completed.

SQL> show con_name

CON_NAME
------------------------------
CDB$ROOT
SQL> 



