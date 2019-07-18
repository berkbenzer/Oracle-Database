SELECT    'alter system kill session '''
       || sess.sid
       || ', '
       || sess.serial#
       || ';'
  FROM v$locked_object lo, dba_objects ao, v$session sess
 WHERE ao.object_id = lo.object_id AND lo.session_id = sess.sid;
