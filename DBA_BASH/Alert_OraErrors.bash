 vi alert.sh 

#!/bin/bash


ORACLE_HOME=/u01/app/oracle/product/11.2.0/db_1
ORACLE_SID=XXXX
ORAENV_ASK=NO
export ORACLE_HOME ORACLE_SID ORAENV_ASK
_my_first_date='1990-01-01 00:00:00'
_my_last_date_file=_my_last_date

[ -f "$_my_last_date_file" ] ||
  printf > ./"$_my_last_date_file" '%s\n' "$_my_first_date"

_last_date=$(<./"$_my_last_date_file")

printf > ./"$_my_last_date_file" '%s\n' "$(
  date '+%Y-%m-%d %H:%M:%S'
  )"

_mailto=berk.benzer@XXXX.com
_mail_subject="Alert for $ORACLE_SID on $HOSTNAME"


_my_result=$(
  adrci exec="
    set home $ORACLE_SID;
    show alert -term -P \\\"MESSAGE_TEXT like '%ORA%' and ORIGINATING_TIMESTAMP >= '$_last_date'\\\"
   "
  )

case $_my_result in
  ( *ORA-* ) mailx -s "$_mail_subject" "$_mailto" <<< "$_my_result"
esac
                                                                                                                                                         
      
