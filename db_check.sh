#!/bin/sh

echo HOSTNAME : `hostname` >>/u01/script/All_Control.txt
echo "tarih : `date`" >>/u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt

echo "######### Disk usage #############" >>/u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt
/bin/df -h>>/u01/script/All_Control.txt 
echo "" >>/u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt

echo "######### Alert log tail -1000 alert.log | grep ORA- #############" >>/u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt
tail -1000 /u01/diag/rdbms/test/TEST/trace/alert_TEST.log | grep ORA- >> /u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt
echo "" >>/u01/script/All_Control.txt

echo "########## Tablespace Doluluk ########" >>/u01/script/All_Control.txt
su - oracle -c "/u01/script/tablespace.sh" >>/u01/script/All_Control.txt

MAIL_TO=""
MAIL_FROM=""
SUBJECT=""
/usr/sbin/sendmail -t <<-EOF
From: ${MAIL_FROM}
To: ${MAIL_TO}
Subject: ${SUBJECT}

`echo "" `

`cat /u01/script/All_Control.txt`

`echo "" `
`echo "" `

EOF
