set echo off feedback off heading on underline on trimspool off ;
SET MARKUP HTML ON SPOOL ON 
SPOOL output.html append;
COLUMN USED_SPACE_GB  FORMAT 999,990 ;
COLUMN TOTAL_SPACE_GB FORMAT 999,990;
COLUMN FREE_SPACE_GB FORMAT 999,990;


SELECT *
  FROM (  SELECT start_time Backup_baslangic_suresi,
                 end_time Backup_bitis_suresi,
                 output_device_type backup_lokasyonu,
                 input_type Backup_Type,
                 status backup_durumu,
                 output_bytes_display backup_boyutu,
                 time_taken_display backup_alma_suresi
            FROM V$RMAN_BACKUP_JOB_DETAILS
        ORDER BY 1 DESC)
 WHERE ROWNUM < 12;


select d.name,d.database_role,d.open_mode,instance_name,status from v$database d,v$instance i where upper(D.NAME)=upper(I.INSTANCE_NAME) ;

spool off;
set markup html off;

exit;
