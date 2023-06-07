

To gather 10046 trace at the session level:
alter session set tracefile_identifier='problem_10046';

alter session set timed_statistics = true;
alter session set statistics_level=all;
alter session set max_dump_file_size = unlimited;

alter session set events '10046 trace name context forever,level 12';

-- sql to take a trace --

select * from dual;
exit;

If the session is not exited then the trace can be disabled using:

alter session set events '10046 trace name context off';
