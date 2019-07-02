
/*
Destinations

*/

--Control File

SELECT NAME FROM V$CONTROLFILE;

/u01/app/oracle/oradata/APM/control01.ctl
/u01/app/oracle/fast_recovery_area/APM/control02.ctl




ISTSL75JDB1P backup]$ pwd
/home/oracle/backup
ISTSL75JDB1P backup]$ mkdir rman

/* Db Kapatalıp mount modda açılır  */
SQL>shutdown immediate
SQL>startup mount;



/*
RMAN ILE BACKUP ALINIR

*/

rman target /


RUN
{
  ALLOCATE CHANNEL ch11 TYPE DISK MAXPIECESIZE 10G;
  BACKUP
  FORMAT '/home/oracle/backup/rman/APM/%d_D_%T_%u_s%s_p%p'
  DATABASE
  CURRENT CONTROLFILE
  FORMAT '/home/oracle/backup/rman/controlfile/%d_C_%T_%u'
  SPFILE
  FORMAT '/home/oracle/backup/rman/spfile/%d_S_%T_%u'
  PLUS ARCHIVELOG
  FORMAT '/home/oracle/backup/rman/archivelog/%d_A_%T_%u_s%s_p%p';
  RELEASE CHANNEL ch11;
}

RMAN> BACKUP DATABASE;
RMAN> list backup;


/* Restore Database*/

RMAN> RESTORE CONTROLFILE FROM "/home/oracle/backup/control01.ctl"; 
RMAN> RESTORE DATABASE;
RMAN> RECOVER DATABASE;
RMAN> ALTER DATABASE OPEN RESETLOGS;




select
    operation,
    status,
    object_type,
    to_char(start_time,'mm/dd/yyyy:hh:mi:ss') as start_time,
    to_char(end_time,'mm/dd/yyyy:hh:mi:ss') as end_time
from
    v$rman_status
where 1=1
and start_time > SYSDATE -1
and operation = 'BACKUP'
and object_type = 'DB FULL'
order by start_time desc;
