##DD PERFORMANCE


linuxtest:]# time sh -c "dd if=/dev/zero of=/tmp/dd-test-file bs=8k count=1000000 && sync"
#1000000+0 records in
#1000000+0 records out
#8192000000 bytes (8.2 GB) copied, 6.80837 s, 1.2 GB/s

#real	0m38.123s
#user	0m0.219s
#sys	0m6.556s


#ORION PERFORMANCE TEST

linuxtest:~]#dd if=/dev/zero of=/u01/luns/lun1 bs=1024k count=10
linuxtest:~]#echo "/u01/luns/lun1" >| simpletest.lun
linuxtest:~]#cat simpletest.lun 
/u01/luns/lun1
linuxtest:~]# /u01/app/oracle/product/11.2.0/dbhome_1/bin/orion -run normal -testname simpletest
ORION: ORacle IO Numbers -- Version 11.2.0.4.0
simpletest_20200115_1057
Calibration will take approximately 19 minutes.
Using a large value for -cache_size may take longer.
















#DBMS_RESOURCE_MANAGER.CALIBRATE_IO


show parameter timed_statistic;
NAME				     TYPE
------------------------------------ --------------------------------
VALUE
------------------------------
timed_statistics		     boolean
TRUE


show parameter STATISTICS_LEVEL ;
NAME				     TYPE
------------------------------------ --------------------------------
VALUE
------------------------------
statistics_level		     string
TYPICAL





##
SELECT d.name,
       i.asynch_io
FROM   v$datafile d,
       v$iostat_file i
WHERE  d.file# = i.file_no
AND    i.filetype_name  = 'Data File';


NAME                                               ASYNCH_IO
-------------------------------------------------- ---------
/u01/app/oracle/oradata/DB11G/system01.dbf         ASYNC_OFF









