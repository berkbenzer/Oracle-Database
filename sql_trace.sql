select * from  v$session
where OSUSER='xxxx'



EXEC DBMS_SYSTEM.set_sql_trace_in_session(sid=>2556,serial#=>83, sql_trace=>TRUE);


create table test_123 (kolon1 varchar2(100));



EXEC DBMS_SYSTEM.set_sql_trace_in_session(sid=>2556,serial#=>83, sql_trace=>FALSE);


SELECT p.tracefile
FROM   v$session s
       JOIN v$process p ON s.paddr = p.addr
WHERE  s.sid = 2556;
