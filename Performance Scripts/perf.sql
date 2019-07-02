with epsilon
as
(select avg(average - STANDARD_DEVIATION ) m1,
        avg(average +  STANDARD_DEVIATION ) m2
from dba_hist_sysmetric_summary
where metric_name='User Calls Per Sec')
select avg(a.average -  a.STANDARD_DEVIATION) "A - Good",
       avg(a.average) "Average",
       avg(a.average + a.STANDARD_DEVIATION)  "B - Bad"
from dba_hist_sysmetric_summary a,
dba_hist_sysmetric_summary b,
epsilon e
where a.metric_name='SQL Service Response Time'
and b.metric_name='User Calls Per Sec'
and a.snap_id = b.snap_id
   and b.average between e.m1 and e.m2
   ;

  A - Good    Average	 B - Bad
---------- ---------- ----------
 -2.561526 1.91509159 6.39170922


/*
If response time bigger then 6.39170922 you need to check the instance.

*/

select to_char(begin_time,'hh24:mi') time,  value "Response Time"
    from v$sysmetric
    where metric_name='SQL Service Response Time';

TIME  Response Time
----- -------------
16:04	 3.31450429
