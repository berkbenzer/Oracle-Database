--Daily
select trunc(COMPLETION_TIME,'DD') Day, thread#, 
round(sum(BLOCKS*BLOCK_SIZE)/1024/1024/1024) GB,
count(*) Archives_Generated from v$archived_log 
group by trunc(COMPLETION_TIME,'DD'),thread# order by 1;

--Hourly
select trunc(COMPLETION_TIME,'HH') Hour,thread# , 
round(sum(BLOCKS*BLOCK_SIZE)/1024/1024/1024) GB,
count(*) Archives from v$archived_log 
group by trunc(COMPLETION_TIME,'HH'),thread#  order by 1 ;
