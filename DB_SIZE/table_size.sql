SELECT *
FROM   (SELECT owner,
               segment_name,
               segment_type,
               tablespace_name,
               ROUND(bytes/1024/1024/1024,2) size_GB
        FROM   dba_segments
        ORDER BY 5 DESC)
WHERE  ROWNUM <= 20;
