--ORA-01940:



select s.sid, s.serial#, s.status, p.spid 
from v$session s, v$process p 
where s.username = 'myuser' 
and p.addr (+) = s.paddr;


ALTER SYSTEM KILL SESSION '380, 7964';
