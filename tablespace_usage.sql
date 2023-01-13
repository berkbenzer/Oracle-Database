/* Formatted on 1/13/2023 12:14:50 PM (QP5 v5.269.14213.34769) */
  SELECT df.tablespace_name tablespace_name,
         MAX (df.autoextensible) auto_ext,
         ROUND (df.maxbytes / (1024 * 1024 * 1024 * 1024), 2) max_ts_size_tb,
         ROUND ( (df.bytes - SUM (fs.bytes)) / (df.maxbytes) * 100, 2)
            max_ts_pct_used,
         ROUND (df.bytes / (1024 * 1024 * 1024 * 1024), 2) curr_ts_size_tb,
         ROUND ( (df.bytes - SUM (fs.bytes)) / (1024 * 1024 * 1024 * 1024), 2)
            used_ts_size_tb,
         ROUND ( (df.bytes - SUM (fs.bytes)) * 100 / df.bytes, 2) ts_pct_used,
         ROUND (SUM (fs.bytes) / (1024 * 1024 * 1024), 2) free_ts_size_gb,
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
         ROUND (df.maxbytes / (1024 * 1024 * 1024 * 1024), 2) max_ts_size_tb,
         ROUND ( (df.bytes - SUM (fs.bytes)) / (df.maxbytes) * 100, 2)
            max_ts_pct_used,
         ROUND (df.bytes / (1024 * 1024 * 1024 * 1024), 2) curr_ts_size_tb,
         ROUND ( (df.bytes - SUM (fs.bytes)) / (1024 * 1024 * 1024 * 1024), 2)
            used_ts_size_tb,
         ROUND ( (df.bytes - SUM (fs.bytes)) * 100 / df.bytes, 2) ts_pct_used,
         ROUND (SUM (fs.bytes) / (1024 * 1024 * 1024), 2) free_ts_size_gb,
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





/*
Column definitions
TABLESPACE_NAME: This is the Tablespace Name.

AUTO_EXT: If the datafiles are ‘Auto Extendable’ or not.

Please Note: This is using a max function, so if all are ‘NO’, then the ‘NO’ is true for all datafiles, however if one is ‘YES’, then the ‘YES’ is possible for one through to all of the datafiles.

MAX_TS_SIZE: This is the maximum Tablespace Size if all the datafile reach their max size.

MAX_TS_PCT_USED: This is the percent of MAX_TS_SIZE reached and is the most important value in the query, as this reflects the true usage before DBA intervention is required.

CURR_TS_SIZE: This is the current size of the Tablespace.

USED_TS_SIZE: This is how much of the CURR_TS_SIZE is used.

TS_PCT_USED: This is the percent of CURR_TS_SIZE which if ‘Auto Extendable’ is on, is a little meaningless.  Use MAX_TS_PCT_USED for actual usage.

FREE_TS_SIZE: This is how much is free in CURR_TS_SIZE.

TS_PCT_FREE: This is how much is free in CURR_TS_SIZE as a percent.

*/
