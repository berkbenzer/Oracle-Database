#!/bin/sh
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | grep  oracle |awk '{ print $5 " " $6 }' | while read output;
do
  echo $output
  usep=$(echo $output | awk '{ print $5}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge 90 ]; then
   find /oracle/diag/tnslsnr/DBISMI/listener/alert/   -name 'log_*' -mtime +2 -exec rm -f {} \;
   find /oracle/diag/rdbms/orcl/orcl/alert/              -name 'log_*' -mtime +2 -exec rm -f {} \;
   find /oracle/diag/rdbms/orcl/orcl/trace/              -name 'cdump' -mtime +2 -exec rm -f {} \;
   find /oracle/diag/rdbms/orcl/orcl/alert/              -name '*.trc' -mtime +2 -exec rm -f {} \;
   find /oracle/diag/rdbms/orcl/orcl/alert/              -name '*.trm' -mtime +2 -exec rm -f {} \;
   echo "" > /oracle/diag/tnslsnr/TRBAHTDB/listener/trace/listener.log
  fi
done
