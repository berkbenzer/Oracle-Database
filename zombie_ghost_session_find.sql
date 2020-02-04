SELECT    'alter system kill session '''
       || sess.sid
       || ', '
       || sess.serial#
       || ';'
  FROM v$locked_object lo, dba_objects ao, v$session sess
 WHERE ao.object_id = lo.object_id AND lo.session_id = sess.sid;



 
 select 'alter system kill session ''' || s.sid || ',' || s.serial# || ''';'
from v$session s, v$process p
where s.username = 'XXX'
and p.addr (+) = s.paddr;

alter system kill session '383,2036'
