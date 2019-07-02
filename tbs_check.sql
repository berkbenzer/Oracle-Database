set linesize 150;
col TABLESPACE_NAME format a15;
select tablespace_name , trunc(trunc(sum(bytes/1024/1024/1024),2)) as
"Current_Size_GB", trunc(trunc(sum(maxbytes/1024/1024/1024),2)) as "MaxAllowed_Size_GB",
trunc(trunc(sum(maxbytes-bytes)/1024/1024/1024,2)) as "GENISLENECEK_ALAN GB",
trunc(trunc(sum(bytes/1024/1024/1024),2)/trunc(sum(maxbytes/1024/1024/1024),2)*100) "DOLULUK_ORANI %"
from dba_data_files
where
autoextensible = 'YES'
group by tablespace_name
order by 1;
exit
exit
