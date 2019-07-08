SET PAUSE ON
SET PAUSE 'Press Return to Continue'
SET PAGESIZE 60
SET LINESIZE 300
 
COLUMN snap_time FORMAT A20
COLUMN name FORMAT A20
COLUMN old_value FORMAT A20
COLUMN new_value FORMAT A20
COLUMN diff FORMAT A20


select 
  to_char(s.begin_interval_time, 'DD-MON-YYYY HH24:MI:SS') snap_time,
  p.instance_number,
  p.snap_id,
  p.name,
  p.old_value,
  p.new_value,
  decode(trim(translate(p.new_value,'0123456789',' ')),'',
  trim(to_char(to_number(p.new_value)-to_number(p.old_value),'999999999999990')),'') diff
from 
  (select dbid,
           instance_number,
           snap_id,
           parameter_name name,
           lag(trim(lower(value)))
             over (
             partition by dbid,
             instance_number,
             parameter_name
             order by snap_id
                    ) old_value,
           trim(lower(value)) new_value,
           decode(nvl(lag(trim(lower(value))) 
              over (
              partition by dbid,
              instance_number,
              parameter_name
              order by snap_id
                     ), 
           trim(lower(value))),
           trim(lower(value)), '~NO~CHANGE~',
           trim(lower(value))) diff
  from dba_hist_parameter
  ) p,
dba_hist_snapshot s
where s.begin_interval_time between trunc(sysdate - &&V_NBR_DAYS) and sysdate
and p.dbid = s.dbid
and p.instance_number = s.instance_number
and p.snap_id = s.snap_id
and p.diff <> '~NO~CHANGE~'
and p.name='&&V_PARAM_NAME'
order by snap_time, instance_number
