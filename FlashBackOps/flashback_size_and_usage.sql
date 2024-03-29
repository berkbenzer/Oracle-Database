SELECT
    (SELECT ROUND(SUM(SPACE_LIMIT)/1024/1024/1024, 2) FROM V$RECOVERY_FILE_DEST) AS flashback_size_gb,
    (SELECT ROUND(SUM(SPACE_USED)/1024/1024/1024, 2) FROM V$RECOVERY_FILE_DEST) AS flashback_used_gb
FROM DUAL;
