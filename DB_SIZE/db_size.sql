select
( select sum(bytes)/1024/1024/1024 data_size from dba_data_files ) +
( select nvl(sum(bytes),0)/1024/1024/1024 temp_size from dba_temp_files ) +
( select sum(bytes)/1024/1024/1024 redo_size from sys.v_$log ) +
( select sum(BLOCK_SIZE*FILE_SIZE_BLKS)/1024/1024/1024 controlfile_size from v$controlfile) "Size in GB"
from
dual;


select sum(bytes)/1024/1024 size_in_mb from dba_data_files;



select owner, sum(bytes)/1024/1024 Size_MB from dba_segments
group  by owner;



--TABLE SIZE TOP 10

select
   *
from (
   select
      owner,
      segment_name,
      bytes/1024/1024/1024 meg
   from
      dba_segments
   where
      segment_type = 'TABLE'
   order by
      bytes/1024/1024 desc)
where
   rownum <= 10;
