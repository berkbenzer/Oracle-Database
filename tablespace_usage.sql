/* Formatted on 11/30/2022 4:12:30 PM (QP5 v5.269.14213.34769) */
  SELECT df.tablespace_name tablespace_name,
         MAX (df.autoextensible) auto_ext,
         ROUND (df.maxbytes / (1024 * 1024), 2) max_ts_size,
         ROUND ( (df.bytes - SUM (fs.bytes)) / (df.maxbytes) * 100, 2)
            max_ts_pct_used,
         ROUND (df.bytes / (1024 * 1024), 2) curr_ts_size,
         ROUND ( (df.bytes - SUM (fs.bytes)) / (1024 * 1024), 2) used_ts_size,
         ROUND ( (df.bytes - SUM (fs.bytes)) * 100 / df.bytes, 2) ts_pct_used,
         ROUND (SUM (fs.bytes) / (1024 * 1024), 2) free_ts_size,
         NVL (ROUND (SUM (fs.bytes) * 100 / df.bytes), 2) ts_pct_free
    FROM dba_free_space fs,
         (  SELECT tablespace_name,
                   SUM (bytes) bytes,
                   SUM (DECODE (maxbytes, 0, bytes, maxbytes)) maxbytes,
                   MAX (autoextensible) autoextensible
              FROM dba_data_files
          GROUP BY tablespace_name) df
   WHERE fs.tablespace_name(+) = df.tablespace_name
GROUP BY df.tablespace_name, df.bytes, df.maxbytes
UNION ALL
  SELECT df.tablespace_name tablespace_name,
         MAX (df.autoextensible) auto_ext,
         ROUND (df.maxbytes / (1024 * 1024), 2) max_ts_size,
         ROUND ( (df.bytes - SUM (fs.bytes)) / (df.maxbytes) * 100, 2)
            max_ts_pct_used,
         ROUND (df.bytes / (1024 * 1024), 2) curr_ts_size,
         ROUND ( (df.bytes - SUM (fs.bytes)) / (1024 * 1024), 2) used_ts_size,
         ROUND ( (df.bytes - SUM (fs.bytes)) * 100 / df.bytes, 2) ts_pct_used,
         ROUND (SUM (fs.bytes) / (1024 * 1024), 2) free_ts_size,
         NVL (ROUND (SUM (fs.bytes) * 100 / df.bytes), 2) ts_pct_free
    FROM (  SELECT tablespace_name, bytes_used bytes
              FROM V$temp_space_header
          GROUP BY tablespace_name, bytes_free, bytes_used) fs,
         (  SELECT tablespace_name,
                   SUM (bytes) bytes,
                   SUM (DECODE (maxbytes, 0, bytes, maxbytes)) maxbytes,
                   MAX (autoextensible) autoextensible
              FROM dba_temp_files
          GROUP BY tablespace_name) df
   WHERE fs.tablespace_name(+) = df.tablespace_name
GROUP BY df.tablespace_name, df.bytes, df.maxbytes
ORDER BY 4 DESC;
